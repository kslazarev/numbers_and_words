# frozen_string_literal: true

require 'spec_helper'
require 'support/locale_characters'

describe NumbersAndWords::I18n do
  describe '.local_language' do
    it 'checks validity of given language and return it as symbol' do
      expect(described_class.local_language(:de)).to eq(:de)
    end

    context 'when string given instead of symbol' do
      it 'correctly normalizes it' do
        allow(I18n).to receive(:locale).and_return(' it ')
        expect(described_class.local_language).to eq(:it)
      end
    end

    context 'when no language given' do
      it 'returns current I18n.locale' do
        allow(I18n).to receive(:locale).and_return(:it)
        expect(described_class.local_language).to eq(:it)
      end
    end

    context 'when a regional variant of a standard code is given' do
      { 'sv-SE': :sv, 'sv-FI': :sv, 'uk-UA': :uk, 'kk-KZ': :kk }.each do |code, language|
        it "maps #{code} to #{language}" do
          expect(described_class.local_language(code)).to eq(language)
        end
      end
    end

    context 'when a locale code used before 1.1.0 is given' do
      # se is Northern Sami; ua and kz are country codes. Swedish, Ukrainian and Kazakh are sv, uk and kk.
      { se: :sv, ua: :uk, kz: :kk }.each do |code, language|
        it "maps #{code} to #{language} with a warning" do
          allow(Kernel).to receive(:warn)
          expect(described_class.local_language(code)).to eq(language)
          expect(Kernel).to have_received(:warn).with(/locale #{code.inspect} is deprecated/, category: nil)
        end
      end
    end

    context 'when unsupported language given' do
      it 'raises error' do
        expect { described_class.local_language('xxx') }.to raise_error('Language not supported')
      end
    end
  end

  describe 'locale files' do
    locales_dir = File.expand_path('../../lib/numbers_and_words/i18n/locales', __dir__)
    lookup_locales = %w[bg ru sk uk]
    scripts = {
      'Latin' => %w[az cs da de en en-GB es et fi fr fr-CH hu id it lt lv ms nb nl pl pt pt-BR ro sk sv tr vi],
      'Cyrillic' => %w[bg kk ru uk],
      'Armenian' => %w[hy],
      'Georgian' => %w[ka],
      'Thai' => %w[th],
      'Han' => %w[zh],
      %w[Han Hiragana Katakana] => %w[ja],
      'Hangul' => %w[ko],
      'Hebrew' => %w[he],
      'Arabic' => %w[ar ur],
      'Devanagari' => %w[hi],
      'Bengali' => %w[bn],
      'Greek' => %w[el]
    }.flat_map { |script, locales| locales.map { |locale| [locale, script] } }.to_h

    Dir[File.join(locales_dir, '*.yml')].each do |path|
      locale = File.basename(path, '.yml').delete_prefix('numbers.')
      script = scripts.fetch(locale)

      it "uses normalized #{Array(script).join(' and ')} translations without invisible characters in #{File.basename(path)}" do
        numbers = YAML.safe_load_file(path).fetch(locale).fetch('numbers')
        # These arrays contain English lookup keys, not translated words, and rule templates (NumbersAndWords::Rules)
        # refer to them by key.
        references = lookup_locales.include?(locale) ? numbers.slice('mega', 'micro') : {}
        translations = numbers.reject { |key, _value| references.key?(key) || key == 'rules' }

        expect(LocaleCharacters.errors(references, 'Latin')).to be_empty
        expect(LocaleCharacters.errors(translations, script)).to be_empty
      end
    end

    it 'uses no Russian-only letters in Ukrainian translations' do
      numbers = YAML.safe_load_file(File.join(locales_dir, 'numbers.uk.yml')).fetch('uk').fetch('numbers')
      russian = LocaleCharacters.strings(numbers).select { |_path, text| text.match?(/[ыэъё]/i) }

      expect(russian).to be_empty
    end
  end
end
