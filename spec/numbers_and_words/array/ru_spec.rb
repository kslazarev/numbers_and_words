require './spec/spec_helper'

describe Array do
  around :each do |example|
    I18n.with_locale(:ru) do
      example.run
    end
  end


  describe 'to_words' do
    context 'simple example' do
      subject { [1, 2, 3] }
      its(:to_words) { should == 3.times.map { |number| t(:ones_male)[number + 1] } }
    end

    context 'complex example' do
      subject { [101, 21, 13] }

      its(:to_words) { should == [
        [t(:hundreds)[1], t(:ones_male)[1]].join(' '),
        [t(:tens)[2], t(:ones_male)[1]].join(' '),
        t(:teens)[3]
      ] }
    end
  end
end
