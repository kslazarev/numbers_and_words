# coding: utf-8
require 'spec_helper'
require 'shared_examples/correct_fixture_examples'

[Numeric, Array].each do |type|
  describe type do
    NumbersAndWords::I18n::Initialization.languages.each do |locale|
      context locale do
        around(:each) { |example| ::I18n.with_locale(locale) { example.run } }

        subject { fixture_examples type, locale }
        it_behaves_like 'correct fixture examples'
      end
    end
  end
end
