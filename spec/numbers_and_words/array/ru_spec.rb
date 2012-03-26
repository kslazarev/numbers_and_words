# coding: utf-8
require 'spec_helper'

describe Array do
  around(:each) { |example| I18n.with_locale(:ru) { example.run } }
  
  describe 'to_words' do
    context 'simple example' do
      subject { [1, 2, 3] }
      its(:to_words) { should == ["один", "два", "три"] }
    end
    context 'complex example' do
      subject { [101, 21, 13] }
      its(:to_words) { should == ["сто один", "двадцать один", "тринадцать"] }
    end
  end
end
