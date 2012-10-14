require 'spec_helper'

describe I18n, 'fr' do
  before(:each) do
    @hash = {}
    %w(one many).each { |key| @hash[key.to_sym] = key }
    @backend = I18n.backend
  end

  it "should pluralize correctly" do
    @backend.send(:pluralize, :'fr', @hash, 1).should == 'one'
    @backend.send(:pluralize, :'fr', @hash, 2).should == 'many'
    @backend.send(:pluralize, :'fr', @hash, 3).should == 'many'
    @backend.send(:pluralize, :'fr', @hash, 5).should == 'many'
    @backend.send(:pluralize, :'fr', @hash, 10).should == 'many'
    @backend.send(:pluralize, :'fr', @hash, 11).should == 'many'
    @backend.send(:pluralize, :'fr', @hash, 21).should == 'one'
    @backend.send(:pluralize, :'fr', @hash, 29).should == 'many'
    @backend.send(:pluralize, :'fr', @hash, 131).should == 'one'
    @backend.send(:pluralize, :'fr', @hash, 1.31).should == 'many'
    @backend.send(:pluralize, :'fr', @hash, 2.31).should == 'many'
    @backend.send(:pluralize, :'fr', @hash, 3.31).should == 'many'
  end
end
