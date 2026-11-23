# frozen_string_literal: true

require 'spec_helper'

LIMIT_MULTIPLIERS = [1, 2].freeze
LONG_DECIMALS = [0.1 + 0.2, 1.0e-15, 0.1234567891234567, 123.45678901234568, *(1..20).map { |digits| 10.0**-digits },
                 *(1..17).map { |digits| "0.#{'1' * digits}".to_f }].freeze
MICRO_PREFIX_KEYS = %w[tens hundreds].freeze
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

  # Floats with 1 to 20 fractional digits, as Float#to_s prints them: each reads completely, ending in its
  # denominator rather than a bare prefix ("одна сто"), or raises RangeError. Readings of 10**-k differ for every k.
  decimal_languages.each do |locale|
    it "reads #{locale} decimals with up to 20 fractional digits completely or raises RangeError" do
      prefixes = I18n.with_locale(locale) { MICRO_PREFIX_KEYS.map { |key| I18n.t("numbers.micro_prefix.#{key}", default: nil) } }.grep(String)
      readings = LONG_DECIMALS.filter_map do |number|
        words(locale, number)
      rescue RangeError => e
        expect(e.message).to match(/\ADecimals in #{locale.inspect} only support up to \d+ fractional digits\.\z|\ANumbers in #{locale.inspect} only support values below 10\*\*\d+\.\z/)
        nil
      end
      readings.each do |reading|
        expect(reading).to eq(reading.strip).and(satisfy { |text| !text.include?('  ') && !text.include?('missing') })
        expect(prefixes).not_to include(reading.split.last)
      end
      powers = (1..20).filter_map { |digits| words(locale, 10.0**-digits) rescue nil } # rubocop:disable Style/RescueModifier -- skips RangeError
      expect(powers.uniq.size).to eq(powers.size)
    end
  end

  it 'raises RangeError past the last fraction word' do
    { ru: 23, uk: 23, be: 23, cs: 23 }.each do |locale, digits|
      expect(words(locale, 10.0**-digits)).not_to be_empty
      expect { words(locale, 10.0**-(digits + 1)) }.to raise_error(RangeError, "Decimals in #{locale.inspect} only support up to #{digits} fractional digits.")
    end
    expect([words(:ru, 0.1 + 0.2), words(:uk, 1.0e-15), words(:cs, 1.0e-17)])
      .to eq(['ноль целых и тридцать квадриллионов четыре стоквадриллионных', 'нуль цілих і одна квадрильйонна', 'nula celá jedna stobiliardtina'])
  end

  it 'raises RangeError past the last scale word' do
    { ar: 36, bg: 36, cs: 36, da: 36, de: 36, el: 36, fi: 36, he: 36, hy: 36, id: 36, ka: 36, ms: 36, nb: 36, ro: 36, sk: 36, sv: 36, hr: 36, bs: 36, sr: 36, sl: 36, et: 36, vi: 36, be: 36, mk: 36,
      en: 48, es: 48, fr: 36, hu: 36, 'pt-BR': 36 }.each do |locale, power|
      expect(words(locale, (10**power) - 1)).not_to be_empty
      expect { words(locale, 10**power) }.to raise_error(RangeError, "Numbers in #{locale.inspect} only support values below 10**#{power}.")
    end
  end

  it 'raises UnsupportedNumberError for decimals in a language without a decimal reading' do
    I18n.reload!
    allow(NumbersAndWords::Strategies::FiguresConverter::Decorators).to receive(:decimals?).and_return(false)
    UNSUPPORTED_DECIMALS.each do |number|
      expect { words(:sv, number) }.to raise_error(NumbersAndWords::UnsupportedNumberError, 'Decimals are not supported in :sv.')
    end
    expect { words(:sv, 1.5, fallback: :en) }.to raise_error(NumbersAndWords::UnsupportedNumberError)
  end

  it 'reads decimals in every language' do
    expect(NumbersAndWords::I18n.languages - decimal_languages).to eq([])
  end

  it 'raises RangeError past the Kazakh fraction words' do
    expect(words(:kk, 0.5, precision: 18)).to start_with('нөл бүтін квинтиллионнан')
    expect { words(:kk, 0.5, precision: 19) }.to raise_error(RangeError, 'Decimals in :kk only support up to 18 fractional digits.')
  end
end
