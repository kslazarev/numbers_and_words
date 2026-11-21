# frozen_string_literal: true

require 'spec_helper'
require 'support/documentation_examples'

# Every option a language accepts is shown in a checked example on its page,
# and every global option in the README. Documenting an unsupported option
# already fails, because documented examples run through option validation.
describe 'option documentation' do # rubocop:disable RSpec/DescribeClass -- checks Markdown files against option classes
  def documented_options(relative_path)
    path = File.expand_path("../../#{relative_path}", __dir__)
    DocumentationExamples.from(path, relative_path).flat_map { |example| example.options.keys }.uniq
  end

  NumbersAndWords::I18n.languages.each do |locale|
    it "shows every #{locale} option on docs/languages/#{locale}.md" do
      options = NumbersAndWords::OptionsValidation.language_options(locale).keys
      expect(options - documented_options("docs/languages/#{locale}.md")).to eq([])
    end
  end

  it 'shows every global option in the README' do
    expect(NumbersAndWords::OptionsValidation::GLOBAL.keys - documented_options('README.md')).to eq([])
  end
end
