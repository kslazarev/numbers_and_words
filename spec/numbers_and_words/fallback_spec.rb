# frozen_string_literal: true

require 'spec_helper'

describe NumbersAndWords::Fallback do
  around do |example|
    available_locales = I18n.available_locales
    locales = NumbersAndWords.config.locales
    fallback = NumbersAndWords.config.fallback
    I18n.available_locales = available_locales + [:am]
    example.run
  ensure
    NumbersAndWords.configure do |config|
      config.locales = locales
      config.fallback = fallback
    end
    I18n.available_locales = available_locales
  end

  context 'with a locale that has no bundled rules' do
    around { |example| I18n.with_locale(:am) { example.run } }

    it 'raises without a fallback' do
      expect { 42.to_words }.to raise_error(NumbersAndWords::UnsupportedLanguageError, 'Language not supported')
    end

    it 'converts integers, floats and arrays in the fallback locale' do
      expect([42.to_words(fallback: :fr), 4.5.to_words(fallback: :en), [1, 2].to_words(fallback: :de)])
        .to eq(['quarante-deux', 'four point five', %w[eins zwei]])
    end

    it 'normalizes the fallback locale and accepts a string option name' do
      expect(42.to_words('fallback' => 'en-US')).to eq('forty-two')
    end

    it 'validates the other options for the fallback locale' do
      expect(42.to_words(fallback: :ru, gender: :female)).to eq('сорок две')
      expect { 42.to_words(fallback: :en, gender: :female) }.to raise_error(NumbersAndWords::UnsupportedOptionError, /:gender is not supported in :en/)
    end

    it 'returns digits with fallback: true' do
      expect([42.to_words(fallback: true), -7.to_words(fallback: true), 4.5.to_words(fallback: true), [1, 2.5].to_words(fallback: true)])
        .to eq(['42', '-7', '4.5', %w[1 2.5]])
    end

    it 'raises with fallback: false or nil' do
      expect { 42.to_words(fallback: false) }.to raise_error(NumbersAndWords::UnsupportedLanguageError)
      expect { 42.to_words(fallback: nil) }.to raise_error(NumbersAndWords::UnsupportedLanguageError)
    end

    [:xx, '', 5, :am].each do |value|
      it "rejects fallback: #{value.inspect}" do
        expect { 42.to_words(fallback: value) }.to raise_error(NumbersAndWords::UnsupportedOptionError, /The fallback .* is not supported/)
      end
    end

    it 'uses the configured fallback' do
      NumbersAndWords.config.fallback = :es
      expect([42.to_words, [1].to_words]).to eq(['cuarenta y dos', ['uno']])
    end

    it 'lets the option override or disable the configured fallback' do
      NumbersAndWords.configure { |config| config.fallback = :es }
      expect(42.to_words(fallback: :fr)).to eq('quarante-deux')
      expect(42.to_words(fallback: true)).to eq('42')
      expect { 42.to_words(fallback: false) }.to raise_error(NumbersAndWords::UnsupportedLanguageError)
    end

    it 'raises when the fallback locale is not enabled by the configuration' do
      NumbersAndWords.configure do |config|
        config.locales = [:en]
        config.fallback = :fr
      end
      expect { 42.to_words }.to raise_error(NumbersAndWords::UnsupportedLanguageError, 'Language not configured')
    end
  end

  context 'with a bundled locale that the configuration disables' do
    it 'converts in the fallback locale' do
      NumbersAndWords.config.locales = [:en]
      expect(I18n.with_locale(:ru) { 42.to_words(fallback: :en) }).to eq('forty-two')
    end
  end

  context 'with a supported locale' do
    it 'ignores the fallback' do
      NumbersAndWords.config.fallback = true
      expect(I18n.with_locale(:en) { [42.to_words(fallback: :fr), 4.5.to_words] }).to eq(['forty-two', 'four point five'])
    end
  end

  describe 'configuration' do
    it 'normalizes the configured fallback locale' do
      NumbersAndWords.config.fallback = 'fr-CA'
      expect(NumbersAndWords.config.fallback).to eq(:fr)
    end

    it 'rejects an unsupported fallback without changing the configuration' do
      NumbersAndWords.config.fallback = :fr
      expect { NumbersAndWords.configure { |config| config.fallback = :xx } }.to raise_error(ArgumentError, /The fallback :xx is not supported/)
      expect(NumbersAndWords.config.fallback).to eq(:fr)
    end

    it 'keeps the fallback when locales are reconfigured' do
      NumbersAndWords.config.fallback = :fr
      NumbersAndWords.configure { |config| config.locales = %i[en fr] }
      expect(NumbersAndWords.config.fallback).to eq(:fr)
    end
  end

  it 'makes UnsupportedLanguageError a RuntimeError, as 1.0 raised' do
    expect(NumbersAndWords::UnsupportedLanguageError.superclass).to eq(RuntimeError)
  end
end
