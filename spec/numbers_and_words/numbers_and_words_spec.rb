# coding: utf-8
require 'spec_helper'
require 'shared_examples/correct_fixture_examples'

[Integer, Array].each do |type|
  describe type do
    NumbersAndWords::I18n.languages.each do |locale|
      context locale do
        around(:each) { |example| ::I18n.with_locale(locale) { example.run } }

        subject { fixture_examples type, locale }
        it_behaves_like 'correct fixture examples'
      end
    end
  end
end


[Float].each do |type|
  describe type do
    [:en, 'en-GB', :hu, :ru, :ua].each do |locale|
      context locale do
        around(:each) { |example| ::I18n.with_locale(locale) { example.run } }

        subject { fixture_examples type, locale }
        it_behaves_like 'correct fixture examples'
      end
    end
  end
end

