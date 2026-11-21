# frozen_string_literal: true

require 'spec_helper'

LIMIT_MULTIPLIERS = [1, 2].freeze
UNSUPPORTED_DECIMALS = [1.5, -1.5, 2.0, [1, 1.5]].freeze

describe 'Language limits' do # rubocop:disable RSpec/DescribeClass -- covers every language
  def words(locale, number, options = {})
    I18n.with_locale(locale) { number.to_words(options) }
  end

  # Spells 10**power and twice it for growing powers until the language raises RangeError: every result
  # until then is a distinct, complete reading, never a bare multiplier left without its scale word.
  NumbersAndWords::I18n.languages.each do |locale|
    it "reads every power of ten in #{locale} until it raises RangeError" do
      LIMIT_MULTIPLIERS.each do |multiplier|
        readings = [words(locale, 0)]
        (0..150).each do |power|
          reading = words(locale, multiplier * (10**power))
          expect(reading).to eq(reading.strip).and(satisfy { |text| !text.include?('  ') && !text.include?('missing') })
          expect(readings).not_to include(reading)
          readings << reading
        rescue RangeError
          break
        end
      end
    end
  end

  it 'raises RangeError past the last scale word' do
    { da: 21, de: 36, sv: 36, et: 36, ka: 12, vi: 18, en: 48, es: 48, fr: 36, hu: 36, 'pt-BR': 36 }.each do |locale, power|
      expect(words(locale, (10**power) - 1)).not_to be_empty
      expect { words(locale, 10**power) }.to raise_error(RangeError, "numbers must be below 10**#{power} in #{locale.inspect}")
    end
  end

  (NumbersAndWords::I18n.languages - decimal_languages).each do |locale|
    it "raises UnsupportedNumberError for #{locale} decimals" do
      UNSUPPORTED_DECIMALS.each do |number|
        expect { words(locale, number) }.to raise_error(NumbersAndWords::UnsupportedNumberError, "decimals are not supported in #{locale.inspect}")
      end
      expect { words(locale, 1.5, fallback: :en) }.to raise_error(NumbersAndWords::UnsupportedNumberError)
    end
  end

  it 'lists the languages without decimals' do
    expect(NumbersAndWords::I18n.languages - decimal_languages).to match_array(%i[ar da et hy ka kk lt lv sv tr])
  end
end
