# frozen_string_literal: true

require 'spec_helper'

# Polish ordinals stop below 1,000, Czech ones below 10,000 and Arabic ones below 100; Hebrew and Arabic ones
# start at 1. Each raises RangeError outside its range.
ORDINAL_RANGES = { pl: 0...1000, cs: 0...10_000, ar: 1...100, he: 1.. }.freeze

# Every language spells ordinals (#263); the fixtures check exact words, and this checks that no number
# falls through a gap in a language's ordinal tables.
describe 'ordinal option' do # rubocop:disable RSpec/DescribeClass -- covers every language
  let(:numbers) do
    [*0..1100, 1999, 2000, 2001, 2021, 9999, 10_000, 21_000, 99_999, 100_000, 999_999, 1_000_000, 2_000_000,
     2_025_000, 21_000_000, 1_000_000_000, 2_000_000_000, 123_456_789]
  end

  NumbersAndWords::I18n.languages.each do |locale|
    it "spells every #{locale} number as a distinct ordinal word" do
      supported = numbers.select { |number| ORDINAL_RANGES.fetch(locale, 0..).cover?(number) }
      ordinals = I18n.with_locale(locale) { supported.map { |number| number.to_words(ordinal: true) } }

      expect(ordinals.grep(/translation missing|\A\s*\z|\b_\b/i)).to eq([])
      expect(ordinals.uniq.size).to eq(supported.size)
    end
  end

  { he: [0], ar: [0, 100] }.each do |locale, numbers|
    it "raises RangeError for #{locale} ordinals of #{numbers.join(' and ')}" do
      numbers.each { |number| expect { I18n.with_locale(locale) { number.to_words(ordinal: true) } }.to raise_error(RangeError) }
    end
  end

  it 'keeps the cardinal form for decimals' do
    expect(I18n.with_locale(:es) { [1.5.to_words(ordinal: true), 1.5.to_words] }.uniq.size).to eq(1)
  end
end
