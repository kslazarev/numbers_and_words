# frozen_string_literal: true

require 'spec_helper'

# Polish ordinals stop below 1,000, Czech and Greek ones below 10,000 and Arabic ones below 100; Hebrew and Arabic ones
# start at 1. Georgian ones of a multiple of a thousand or more need a multiplier of one. Each raises RangeError outside
# its range.
GEORGIAN_ORDINALS = Class.new do
  def self.cover?(number)
    return true if number.zero? || !(number % 1000).zero?

    number /= 1000 while (number % 1000).zero?
    number % 1000 == 1
  end
end
# Ordinals of a scale word that don't start like its cardinal: Romanian builds "miilea" on the plural "mii", and
# Hungarian "ezredik" drops the e of "ezer" and "milliomodik" omits the cardinal's leading "egy".
ORDINAL_SCALE_STEM_EXCEPTIONS = [[:ro, 1000], [:hu, 1000], [:hu, 1_000_000]].freeze
SMALL_ORDINALS = [0, 1, 2].freeze
ORDINAL_DECIMALS = [1.5, 21.25, -1.5, 2.0, [1.5, 2.25]].freeze
ORDINAL_RANGES = { pl: 0...1000, cs: 0...10_000, el: 0...10_000, ar: 1...100, he: 1.., ka: GEORGIAN_ORDINALS }.freeze

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

  { he: [0], ar: [0, 100], ka: [2000, 21_000, 100_000, 2_000_000, 2_025_000] }.each do |locale, numbers|
    it "raises RangeError for #{locale} ordinals of #{numbers.join(' and ')}" do
      numbers.each { |number| expect { I18n.with_locale(locale) { number.to_words(ordinal: true) } }.to raise_error(RangeError) }
    end
  end

  # The ordinal of every power of a thousand, once and twice, up to the last cardinal scale word: a scale table
  # shorter than or out of step with the cardinal mega list gives an empty, repeated or wrong scale word.
  NumbersAndWords::I18n.languages.each do |locale|
    it "spells the #{locale} ordinal of every scale word" do
      I18n.with_locale(locale) do
        scales = (1..50).map { |power| 10**(3 * power) }.take_while { |number| number.to_words && true rescue false } # rubocop:disable Style/RescueModifier -- stops at the cardinal limit
        numbers = scales.flat_map { |number| [number, 2 * number] }.select { |number| ORDINAL_RANGES.fetch(locale, 0..).cover?(number) }
        ordinals = numbers.map { |number| number.to_words(ordinal: true) }
        expect(ordinals.grep(/translation missing|\A\s*\z|\b_\b/i)).to eq([])
        expect(ordinals.uniq.size).to eq(numbers.size)
        small = SMALL_ORDINALS.select { |number| ORDINAL_RANGES.fetch(locale, 0..).cover?(number) }
        expect(ordinals).not_to include(*small.map { |number| number.to_words(ordinal: true) })
        mismatched = numbers.zip(ordinals).reject do |number, ordinal|
          number.to_s[0] == '2' || plain(ordinal).include?(plain(number.to_words.split.last)[0, 3]) || ORDINAL_SCALE_STEM_EXCEPTIONS.include?([locale, number])
        end
        expect(mismatched).to eq([])
      end
    end
  end

  def plain(text)
    text.unicode_normalize(:nfd).gsub(/\p{Mn}/, '').downcase
  end

  it 'keeps the cardinal form for decimals in every language' do
    decimal_languages.each do |locale|
      I18n.with_locale(locale) do
        ORDINAL_DECIMALS.each do |number|
          expect(number.to_words(ordinal: true)).to eq(number.to_words), "#{locale} #{number}"
        end
      end
    end
  end
end
