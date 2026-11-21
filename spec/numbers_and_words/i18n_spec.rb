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

    context 'when unsupported language given' do
      it 'raises error' do
        expect { described_class.local_language('xxx') }.to raise_error('Language not supported')
      end
    end
  end

  describe 'locale files' do
    locales_dir = File.expand_path('../../lib/numbers_and_words/i18n/locales', __dir__)
    lookup_locales = %w[ru ua]
    scripts = {
      'Latin' => %w[cs da de en en-GB es et fr fr-CH hu it lt lv nl pl pt pt-BR se tr vi],
      'Cyrillic' => %w[kz ru ua],
      'Armenian' => %w[hy],
      'Georgian' => %w[ka],
      'Thai' => %w[th]
    }.flat_map { |script, locales| locales.map { |locale| [locale, script] } }.to_h

    Dir[File.join(locales_dir, '*.yml')].each do |path|
      locale = File.basename(path, '.yml').delete_prefix('numbers.')
      script = scripts.fetch(locale)

      it "uses normalized #{script} translations without invisible characters in #{File.basename(path)}" do
        numbers = YAML.safe_load_file(path).fetch(locale).fetch('numbers')
        # These arrays contain English lookup keys, not translated words.
        references = lookup_locales.include?(locale) ? numbers.slice('mega', 'micro') : {}
        translations = numbers.reject { |key, _value| references.key?(key) }

        expect(LocaleCharacters.errors(references, 'Latin')).to be_empty
        expect(LocaleCharacters.errors(translations, script)).to be_empty
      end
    end

    it 'uses no Russian-only letters in Ukrainian translations' do
      numbers = YAML.safe_load_file(File.join(locales_dir, 'numbers.ua.yml')).fetch('ua').fetch('numbers')
      russian = LocaleCharacters.strings(numbers).select { |_path, text| text.match?(/[ыэъё]/i) }

      expect(russian).to be_empty
    end
  end
end
