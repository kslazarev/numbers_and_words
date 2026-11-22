# frozen_string_literal: true

require 'spec_helper'

describe NumbersAndWords::Strategies::FiguresConverter::Options::Proxy do
  describe '#method_missing' do
    it 'keeps repeated option calls sensitive to current option values' do
      I18n.with_locale(:en) do
        options = {}
        proxy = described_class.new(double, options)

        expect(proxy.remove_hyphen.result).to eq('-')
        options[:remove_hyphen] = true
        expect(proxy.remove_hyphen.result).to eq(' ')
      end
    end

    it 'separates cached names when the same proxy is used in different locales' do
      proxy = described_class.new(double, { gender: :female })

      I18n.with_locale(:en) { expect(proxy.gender).to be_nil }
      I18n.with_locale(:ru) { expect(proxy.gender.result).to eq(:female) }
      I18n.with_locale(:en) { expect(proxy.gender).to be_nil }
    end

    it 'resolves extensions added after a miss and passes fresh arguments and blocks' do
      I18n.with_locale(:en) do
        proxy = described_class.new(double, {})
        expect(proxy.custom_extension).to be_nil

        extension = Class.new do
          def initialize(_proxy, arguments, block)
            @arguments = arguments
            @block = block
          end

          def result
            @block.call(*@arguments)
          end
        end
        stub_const('NumbersAndWords::Strategies::FiguresConverter::Options::En::CustomExtension', extension)

        expect(proxy.custom_extension(10) { |value| value * 2 }.result).to eq(20)
        expect(proxy.custom_extension(30) { |value| value * 3 }.result).to eq(90)
      end
    end

    context 'when unexisting method called' do
      it 'rescues from NameError and returns nil' do
        proxy = described_class.new(double, {})
        expect(proxy.existing_method).to be_nil
      end
    end
  end

  describe '#respond_to?' do
    it 'answers for the options the language defines' do
      proxy = described_class.new(double, {})
      I18n.with_locale(:en) do
        expect(proxy).to respond_to(:ordinal)
        expect(proxy).not_to respond_to(:gender)
      end
    end
  end
end
