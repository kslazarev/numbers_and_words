# frozen_string_literal: true

require 'spec_helper'

describe NumbersAndWords::Wrappers do
  around { |example| I18n.with_locale(:en) { example.run } }

  describe NumbersAndWords::Wrappers::Integer do
    it 'handles zero and negative numbers without changing digit order' do
      expect(described_class.new(0).to_words).to eq('zero')
      expect(described_class.new(-1001).to_words).to eq('minus one thousand one')
    end

    it 'keeps all digits of integers beyond machine word size' do
      expect(described_class.new((10**30) + 123).to_words).to eq('one nonillion one hundred twenty-three')
    end

    it 'reads a Vietnamese negative number with âm, not as a zero hundred' do
      I18n.with_locale(:vi) { expect(described_class.new(-42).to_words).to eq('âm bốn mươi hai') }
    end
  end

  describe NumbersAndWords::Wrappers::Float do
    it 'expands small scientific notation without retaining the artificial mantissa zero' do
      expect(described_class.new(1.0e-5).to_words(fraction: true)).to eq('zero and one hundred-thousandth')
    end

    it 'keeps all significant mantissa digits in scientific notation' do
      expect(described_class.new(1.2e-5).to_words(fraction: true)).to eq('zero and twelve millionths')
    end

    it 'applies precision after expanding scientific notation' do
      expect(described_class.new(1.0e-5).to_words(precision: 6, fraction: true)).to eq('zero and ten millionths')
    end

    it 'rounds to a precision shorter than the fractional part' do
      I18n.with_locale(:'en-GB') do
        expect([0.129.to_words(precision: 2), 0.001.to_words(precision: 2), 1.5.to_words(precision: 0)])
          .to eq(['zero point one three', 'zero', 'two'])
      end
    end

    it 'reads nothing for zero with remove_zero, without the decimal word' do
      expect(%i[en en-GB da fi].map { |locale| I18n.with_locale(locale) { 0.0.to_words(remove_zero: true) } }).to eq(['', '', '', ''])
    end

    it 'counts the integral part of a German decimal whatever its gender' do
      I18n.with_locale(:de) { expect(1.5.to_words(gender: :female)).to eq('eins Komma fünf') }
    end

    it 'expands large scientific notation into the full integral magnitude' do
      expect(described_class.new(1.0e20).to_words).to eq('one hundred quintillion')
    end

    it 'keeps the minus word after scientific expansion' do
      expect([described_class.new(-1.0e20).to_words, described_class.new(-1.0e-5).to_words(fraction: true)])
        .to eq(['minus one hundred quintillion', 'minus zero and one hundred-thousandth'])
    end

    it 'leaves the number unchanged when a wrapper is reused for a negative number' do
      wrapper = described_class.new(-1.5)
      expect([wrapper.to_words, wrapper.to_words, wrapper.number]).to eq(['minus one point five', 'minus one point five', -1.5])
    end

    it 'refreshes split parts and precision when a wrapper is reused' do
      wrapper = described_class.new(1.25)
      expect(wrapper.to_words(precision: 3, fraction: true)).to eq('one and two hundred fifty thousandths')
      expect(wrapper.to_words(fraction: true)).to eq('one and twenty-five hundredths')

      wrapper.number = 0.1
      expect(wrapper.to_words).to eq('zero point one')
      wrapper.number = 1.0
      expect(wrapper.to_words(precision: 3)).to eq('one')
    end
  end
end
