require File.dirname(__FILE__) + '/../spec_helper'

describe Array do
  around :each do |example|
    I18n.with_locale(:ru) do
      example.run
    end
  end

  describe 'to_words' do
    subject { [1, 2, 3] }
    its(:to_words) { should == [
      I18n.t(:ones_male, :scope => FiguresArray::I18N_NAMESPACE)[1],
        I18n.t(:ones_male, :scope => FiguresArray::I18N_NAMESPACE)[2],
        I18n.t(:ones_male, :scope => FiguresArray::I18N_NAMESPACE)[3]
    ] }
  end
end
