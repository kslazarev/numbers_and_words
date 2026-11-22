# frozen_string_literal: true

require 'spec_helper'

describe 'numbers.supported_options' do # rubocop:disable RSpec/DescribeClass -- checks options declared in locale files
  after { I18n.reload! }

  it 'accepts an option declared after the options were read' do
    I18n.with_locale(:en) do
      expect(NumbersAndWords::OptionsValidation.supported_options(:en)).not_to include(:gender)
      I18n.backend.store_translations(:en, numbers: { supported_options: { gender: { values: %w[male female], default: 'female' } } })
      expect(NumbersAndWords::OptionsValidation.supported_options(:en)[:gender]).to eq(%i[male female])
    end
  end

  it 'gives an option its declared default' do
    I18n.with_locale(:en) do
      I18n.backend.store_translations(:en, numbers: { supported_options: { gender: { values: %w[male female], default: 'female' } } })
      proxy = NumbersAndWords::Strategies::FiguresConverter::Options::Proxy.new(double, {})
      expect(proxy).to respond_to(:gender)
      expect(proxy.gender.result).to eq(:female)
      expect(NumbersAndWords::Strategies::FiguresConverter::Options::Proxy.new(double, { gender: 'male' }).gender.result).to eq(:male)
    end
  end

  it 'gives a true or false option its value' do
    I18n.with_locale(:en) do
      expect(NumbersAndWords::Strategies::FiguresConverter::Options::Proxy.new(double, { ordinal: true }).ordinal.result).to be(true)
      expect(NumbersAndWords::Strategies::FiguresConverter::Options::Proxy.new(double, {}).ordinal.result).to be_nil
      expect(NumbersAndWords::Strategies::FiguresConverter::Options::Proxy.new(double, {})).not_to respond_to(:gender)
    end
  end
end
