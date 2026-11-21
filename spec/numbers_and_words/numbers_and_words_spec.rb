# frozen_string_literal: true

require 'spec_helper'
require 'shared_examples/correct_fixture_examples'

[Integer, Array].each do |type|
  describe type do
    NumbersAndWords::I18n.languages.each do |locale|
      context locale do
        around { |example| I18n.with_locale(locale) { example.run } }

        it_behaves_like 'correct fixture examples', fixture_examples(type, locale)
      end
    end
  end
end

FLOAT_CAPABLE_LANGUAGES = %i[bn cs de en-GB en es it fr fr-CH he hi hu ja ko nl pl pt pt-BR ru th uk ur vi zh].freeze
[Float].each do |type|
  describe type do
    FLOAT_CAPABLE_LANGUAGES.each do |locale|
      context locale do
        around { |example| I18n.with_locale(locale) { example.run } }

        it_behaves_like 'correct fixture examples', fixture_examples(type, locale)
      end
    end
  end
end
