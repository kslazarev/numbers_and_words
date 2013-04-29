require 'spec_helper'

describe I18n, 'ru' do
  before(:each) do
    @hash = {}
    %w(one few many other).each { |key| @hash[key.to_sym] = key }
    @backend = I18n.backend
  end

  it "should pluralize correctly" do
    @backend.send(:pluralize, :'ru', @hash, 1).should eq('one')
    @backend.send(:pluralize, :'ru', @hash, 2).should eq('few')
    @backend.send(:pluralize, :'ru', @hash, 3).should eq('few')
    @backend.send(:pluralize, :'ru', @hash, 5).should eq('many')
    @backend.send(:pluralize, :'ru', @hash, 10).should eq('many')
    @backend.send(:pluralize, :'ru', @hash, 11).should eq('many')
    @backend.send(:pluralize, :'ru', @hash, 21).should eq('one')
    @backend.send(:pluralize, :'ru', @hash, 29).should eq('many')
    @backend.send(:pluralize, :'ru', @hash, 131).should eq('one')
    @backend.send(:pluralize, :'ru', @hash, 1.31).should eq('other')
    @backend.send(:pluralize, :'ru', @hash, 2.31).should eq('other')
    @backend.send(:pluralize, :'ru', @hash, 3.31).should eq('other')
  end
end
