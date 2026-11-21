# frozen_string_literal: true

require 'spec_helper'

NEGATIVE_EXAMPLES = [1, 42, 1001].freeze

describe 'Negative numbers' do # rubocop:disable RSpec/DescribeClass -- covers Integer, Float and Array in every language
  def words(locale, number, options = {})
    I18n.with_locale(locale) { number.to_words(options) }
  end

  def minus(locale)
    I18n.t('numbers.minus', locale:)
  end

  NumbersAndWords::I18n.languages.each do |locale|
    it "reads #{locale} negative integers as the minus word and the absolute value" do
      separator = NumbersAndWords::Unit::UNSPACED.include?(locale) ? '' : ' '
      NEGATIVE_EXAMPLES.each do |number|
        expect(words(locale, -number)).to eq("#{minus(locale)}#{separator}#{words(locale, number)}")
      end
      expect(words(locale, [-2, 2])).to eq(["#{minus(locale)}#{separator}#{words(locale, 2)}", words(locale, 2)])
    end

    it "rejects #{locale} ordinals of negative numbers" do
      expect { words(locale, -1, ordinal: true) }.to raise_error(NumbersAndWords::UnsupportedNumberError, 'negative numbers have no ordinal: -1')
      expect(words(locale, -1, ordinal: false)).to eq(words(locale, -1))
    end
  end

  decimal_languages.each do |locale|
    it "reads #{locale} negative decimals as the minus word and the absolute value" do
      separator = NumbersAndWords::Unit::UNSPACED.include?(locale) ? '' : ' '
      expect(words(locale, -1.5)).to eq("#{minus(locale)}#{separator}#{words(locale, 1.5)}")
      expect(words(locale, -0.0)).not_to start_with(minus(locale))
    end
  end

  it 'reads negative numbers in a few languages' do
    expect([words(:en, -5), words(:fr, -21), words(:vi, -42), words(:zh, -42), words(:ja, -5), words(:th, -5), words(:ru, -1.5), words(:de, -1)])
      .to eq(['minus five', 'moins vingt-et-un', 'âm bốn mươi hai', '负四十二', 'マイナス五', 'ลบห้า', 'минус одна целая и пять десятых', 'minus eins'])
  end
end
