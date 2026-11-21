# frozen_string_literal: true

require 'spec_helper'
require 'support/documentation_examples'

# Runs every documented example without evaluating documentation text: each
# example is parsed into a locale, a number and literal options, and only
# to_words is called.
describe 'documentation examples' do # rubocop:disable RSpec/DescribeClass -- checks Markdown files, not a class
  root = File.expand_path('../..', __dir__)
  files = [File.join(root, 'README.md'), *Dir[File.join(root, 'docs/languages/*.md')]].sort
  examples = files.flat_map { |path| DocumentationExamples.from(path, path.delete_prefix("#{root}/")) }

  it 'finds examples in the README and every language page' do
    expect(examples.map(&:path).uniq.size).to eq(files.size)
  end

  examples.each do |example|
    it "#{example.path}:#{example.line} #{example.code}" do
      words = I18n.with_locale(example.locale) { example.receiver.to_words(example.options) }

      expect(words.inspect).to eq(example.expected)
    end
  end

  describe DocumentationExamples do
    it 'parses a locale, a number and literal options' do
      example = described_class.parse('doc.md', 1, "I18n.with_locale(:'en-GB') { 1_001.to_words(gender: :female, precision: 2, ordinal: true) }", '# => "x"')

      expect(example.to_h.slice(:locale, :receiver, :options)).to eq(locale: :'en-GB', receiver: 1001, options: { gender: :female, precision: 2, ordinal: true })
    end

    it 'parses floats and arrays' do
      expect(described_class.parse('doc.md', 1, 'I18n.with_locale(:en) { [0.1, 21].to_words }', '# => []').receiver).to eq([0.1, 21])
    end

    it 'rejects anything other than a to_words call with literal options' do
      ['I18n.with_locale(:en) { system("ls") }',
       'I18n.with_locale(:en) { 1.to_words(gender: File.read("x")) }',
       'I18n.with_locale(:en) { 1.to_words; exit }',
       'I18n.with_locale(:en) { `ls`.to_words }',
       'I18n.with_locale(:en) { 1.send(:to_words) }'].each do |code|
        expect { described_class.parse('doc.md', 1, code, '# => ""') }.to raise_error(ArgumentError, /unsupported example/)
      end
    end

    it 'requires a documented result' do
      expect { described_class.parse('doc.md', 1, 'I18n.with_locale(:en) { 1.to_words }', 'one') }.to raise_error(ArgumentError, /missing/)
    end
  end
end
