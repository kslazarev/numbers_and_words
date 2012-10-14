# coding: utf-8
require 'spec_helper'
require 'numbers_and_words/integer/shared_examples/correct_fixture_examples'

describe Integer do
  around(:each) { |example| ::I18n.with_locale(:fr) { example.run } }

  subject { fixture_examples }
  it_behaves_like 'correct fixture examples'
end
