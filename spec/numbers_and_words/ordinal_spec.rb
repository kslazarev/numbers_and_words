# frozen_string_literal: true

require 'spec_helper'

# Hebrew has ordinal words only for 1 to 10, and Arabic ordinals agree in form with what they count;
# both are still to come (#263).
LANGUAGES_WITHOUT_ORDINALS = %i[ar he].freeze
# Polish ordinals stop below 1,000 and Czech ones below 10,000; both raise RangeError above.
ORDINAL_LIMITS = { pl: 1000, cs: 10_000 }.freeze

# Every language spells ordinals (#263); the fixtures check exact words, and this checks that no number
# falls through a gap in a language's ordinal tables.
describe 'ordinal option' do # rubocop:disable RSpec/DescribeClass -- covers every language
  let(:numbers) do
    [*0..1100, 1999, 2000, 2001, 2021, 9999, 10_000, 21_000, 99_999, 100_000, 999_999, 1_000_000, 2_000_000,
     2_025_000, 21_000_000, 1_000_000_000, 2_000_000_000, 123_456_789]
  end

  (NumbersAndWords::I18n.languages - LANGUAGES_WITHOUT_ORDINALS).each do |locale|
    it "spells every #{locale} number as a distinct ordinal word" do
      supported = numbers.select { |number| number < ORDINAL_LIMITS.fetch(locale, Float::INFINITY) }
      ordinals = I18n.with_locale(locale) { supported.map { |number| number.to_words(ordinal: true) } }

      expect(ordinals.grep(/translation missing|\A\s*\z|\b_\b/i)).to eq([])
      expect(ordinals.uniq.size).to eq(supported.size)
    end
  end

  LANGUAGES_WITHOUT_ORDINALS.each do |locale|
    it "rejects ordinal: true in #{locale}" do
      expect { I18n.with_locale(locale) { 1.to_words(ordinal: true) } }.to raise_error(NumbersAndWords::UnsupportedOptionError)
    end
  end

  it 'keeps the cardinal form for decimals' do
    expect(I18n.with_locale(:es) { [1.5.to_words(ordinal: true), 1.5.to_words] }.uniq.size).to eq(1)
  end
end
