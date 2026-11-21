# frozen_string_literal: true

require 'spec_helper'
require 'support/documentation_examples'
require 'tempfile'

# Runs every documented example without evaluating documentation text: each
# example is parsed into a locale, a number and literal options, and only
# to_words is called.
describe 'documentation examples' do # rubocop:disable RSpec/DescribeClass -- checks Markdown files, not a class
  root = File.expand_path('../..', __dir__)
  files = [File.join(root, 'README.md'), *Dir[File.join(root, 'docs/languages/*.md')]].sort
  examples = files.flat_map { |path| DocumentationExamples.from(path, path.delete_prefix("#{root}/")) }
  units = DocumentationExamples.unit_translations(File.join(root, 'README.md'))

  it 'finds examples in the README and every language page' do
    expect(examples.map(&:path).uniq.size).to eq(files.size)
  end

  examples.each do |example|
    it "#{example.path}:#{example.line} #{example.code}" do
      # Unit examples use the application translations documented in the README, in a backend of their own.
      backend = I18n.backend
      if example.options.key?(:unit)
        I18n.backend = I18n::Backend::Simple.new
        units.each { |locale, translations| I18n.backend.store_translations(locale, translations) }
      end
      # An application renders pages in its own locales, including ones without bundled rules (see fallback).
      available_locales = I18n.available_locales
      I18n.available_locales = available_locales | [example.locale]
      words = I18n.with_locale(example.locale) { example.receiver.to_words(example.options) }

      expect(words.inspect).to eq(example.expected)
    ensure
      I18n.available_locales = available_locales
      I18n.backend = backend
    end
  end

  describe DocumentationExamples do
    it 'parses a locale, a number and literal options' do
      example = described_class.parse('doc.md', 1, "I18n.with_locale(:'en-GB') { 1_001.to_words(gender: :female, precision: 2, ordinal: true) }", '# => "x"')

      expect(example.to_h.slice(:locale, :receiver, :options)).to eq(locale: :'en-GB', receiver: 1001, options: { gender: :female, precision: 2, ordinal: true })
    end

    it 'parses plain string option values' do
      expect(described_class.parse('doc.md', 1, 'I18n.with_locale(:en) { 21.77.to_words(micro_separator: "plus") }', '# => ""').options).to eq(micro_separator: 'plus')
    end

    it 'parses floats and arrays' do
      expect(described_class.parse('doc.md', 1, 'I18n.with_locale(:en) { [0.1, 21].to_words }', '# => []').receiver).to eq([0.1, 21])
    end

    it 'rejects anything other than a to_words call with literal options' do
      ['I18n.with_locale(:en) { system("ls") }',
       'I18n.with_locale(:en) { 1.to_words(gender: File.read("x")) }',
       'I18n.with_locale(:en) { 1.to_words; exit }',
       'I18n.with_locale(:en) { `ls`.to_words }',
       'I18n.with_locale(:en) { 1.send(:to_words) }',
       'I18n.with_locale(:en) { 1.to_words(micro_separator: "#{exit}") }', # rubocop:disable Lint/InterpolationCheck -- literal input that must be rejected
       'I18n.with_locale(:en) { 1.to_words(micro_separator: "\\" + x) }'].each do |code|
        expect { described_class.parse('doc.md', 1, code, '# => ""') }.to raise_error(ArgumentError, /unsupported example/)
      end
    end

    it 'reads the unit translations under the ### Unit heading' do
      Tempfile.create(['units', '.md']) do |file|
        file.write("### Unit\n\n```yaml\nen:\n  units:\n    dollar: dollars\n```\n")
        file.flush
        expect(described_class.unit_translations(file.path)).to eq('en' => { 'units' => { 'dollar' => 'dollars' } })
      end
    end

    it 'requires unit translations' do
      Tempfile.create(['units', '.md']) do |file|
        expect { described_class.unit_translations(file.path) }.to raise_error(ArgumentError, /no YAML block under ### Unit/)
      end
    end

    it 'requires a documented result' do
      expect { described_class.parse('doc.md', 1, 'I18n.with_locale(:en) { 1.to_words }', 'one') }.to raise_error(ArgumentError, /missing/)
    end
  end
end
