# frozen_string_literal: true

require 'spec_helper'
require 'support/locale_characters'

describe LocaleCharacters do
  describe '.errors' do
    [
      %w[Cyrillic шiсть],
      %w[Cyrillic i],
      %w[Latin cаt],
      %w[Latin ο],
      %w[Armenian աa],
      %w[Georgian აa],
      %w[Hangul 일a],
      [%w[Han Hiragana], 'いちイチ']
    ].each do |script, word|
      it "rejects wrong-script letters in #{word.dump} for #{script}" do
        expect(described_class.errors({ 'word' => word }, script)).not_to be_empty
      end
    end

    it 'checks decoded YAML values, including escaped characters' do
      translations = YAML.safe_load('word: "c\u0430t"')

      expect(described_class.errors(translations, 'Latin')).not_to be_empty
    end

    it 'reports nested keys, array indexes and offending code points' do
      translations = { 'ones' => [nil, { 'female' => "\u0434\u0432e" }] }

      expect(described_class.errors(translations, 'Cyrillic'))
        .to contain_exactly(a_string_including('ones.1.female', 'U+0065'))
    end

    it 'rejects decomposed accents' do
      expect(described_class.errors({ 'word' => "e\u0301" }, 'Latin'))
        .to contain_exactly(a_string_including('not NFC-normalized'))
    end

    ["\u200B", "\u202E", "\uFEFF", "\u034F", "\t", "\n", "\u2028", "\u2029"].each do |character|
      it "rejects invisible character #{character.dump}" do
        expect(described_class.errors({ 'word' => "one#{character}" }, 'Latin'))
          .to include(a_string_including('invisible control/format characters'))
      end
    end

    it 'allows native scripts, accents, combining marks, punctuation and spaces' do
      {
        'Latin' => ["\u00e9", "q\u0301", 'twenty-one', "l\u2019un", 'səksən', 'qırx', 'üçüncü', 'beş', ' ', '', '_', 1, nil],
        'Cyrillic' => ["\u0456", "\u043f\u2019\u044f\u0442\u044c"],
        'Armenian' => ["\u0574\u0565\u056f"],
        'Georgian' => ["\u10d4\u10e0\u10d7\u10d8"],
        'Hangul' => ['이십일'],
        %w[Han Hiragana] => %w[三百 さんびゃく]
      }.each do |script, words|
        expect(described_class.errors(words, script)).to be_empty
      end
    end
  end
end
