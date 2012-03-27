# coding: utf-8
require 'spec_helper'
require 'numbers_and_words/integer/shared_examples_for_integer'

describe Integer do
  around(:each) { |example| I18n.with_locale(:ru) { example.run } }

  yml_examples.each do |method_name, examples|
    context "##{method_name}" do
      let(:method_name) { method_name }

      context 'examples' do
        subject { examples }
        it_behaves_like 'correct examples'
      end
    end
  end
end
