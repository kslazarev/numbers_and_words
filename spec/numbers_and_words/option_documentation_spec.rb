# frozen_string_literal: true

require 'spec_helper'
require 'support/documentation_examples'

# Every option a language accepts is shown in a checked example on its page, including
# precision and micro_separator where the language supports decimals, and every global option in the README. Documenting an unsupported option
# already fails, because documented examples run through option validation.
describe 'option documentation' do # rubocop:disable RSpec/DescribeClass -- checks Markdown files against option classes
  def documented_options(relative_path)
    path = File.expand_path("../../#{relative_path}", __dir__)
    DocumentationExamples.from(path, relative_path).flat_map { |example| example.options.keys }.uniq
  end

  def decimals?(locale)
    NumbersAndWords::Strategies::FiguresConverter::Decorators.const_defined?(locale.to_s.split('-').map(&:capitalize).join, false)
  end

  NumbersAndWords::I18n.languages.each do |locale|
    it "shows every #{locale} option on docs/languages/#{locale}.md" do
      page = "docs/languages/#{locale}.md"
      options = NumbersAndWords::OptionsValidation.language_options(locale).keys
      options += NumbersAndWords::OptionsValidation::GLOBAL.keys if decimals?(locale)
      expect(options - documented_options(page)).to eq([])
    end

    it "documents decimals and every shared option on docs/languages/#{locale}.md" do
      text = File.read(File.expand_path("../../docs/languages/#{locale}.md", __dir__))
      headings = text.scan(/^##+ .+$/)
      expect(headings).to include('## Decimals', '## Options', '### Precision', '### Micro Separator')
      expect(text.include?('Decimals are not supported yet.')).to eq(!decimals?(locale))
    end
  end

  it 'shows every global option in the README' do
    expect(NumbersAndWords::OptionsValidation::GLOBAL.keys - documented_options('README.md')).to eq([])
  end
end
