# frozen_string_literal: true

require 'spec_helper'

describe NumbersAndWords::Wrappers do
  around { |example| I18n.with_locale(:en) { example.run } }

  describe NumbersAndWords::Wrappers::Integer do
    it 'handles zero and negative magnitudes without changing digit order' do
      expect(described_class.new(0).to_words).to eq('zero')
      expect(described_class.new(-1001).to_words).to eq('one thousand one')
    end

    it 'keeps all digits of integers beyond machine word size' do
      expect(described_class.new((10**30) + 123).to_words).to eq('one nonillion one hundred twenty-three')
    end

    it 'preserves the leading zero used by Vietnamese negative magnitudes' do
      I18n.with_locale(:vi) do
        expect(described_class.new(-42).to_words).to eq("kh\u00f4ng tr\u0103m b\u1ed1n m\u01b0\u01a1i hai")
      end
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

    it 'expands large scientific notation into the full integral magnitude' do
      expect(described_class.new(1.0e20).to_words).to eq('one hundred quintillion')
    end

    it 'preserves existing negative-magnitude handling after scientific expansion' do
      expect(described_class.new(-1.0e20).to_words).to eq('one hundred quintillion')
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
