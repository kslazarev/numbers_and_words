require 'spec_helper'

describe Array do
  around(:each) { |example| I18n.with_locale(:fr) { example.run } }

  describe '#to_words' do
    context 'simple example' do
      subject { [1, 2, 3] }
      its(:to_words) { should == [ "un", "deux", "trois" ] }
    end

    context 'complex example' do
      subject { [101, 21, 13] }
      its(:to_words) { should == ["cent un", "vingt et un", "treize"] }
    end
  end
end
