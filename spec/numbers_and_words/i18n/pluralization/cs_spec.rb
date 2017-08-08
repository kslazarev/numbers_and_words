require 'spec_helper'

describe I18n, 'cs' do
  before(:each) do
    @hash = {}
    %w[one few many other].each { |key| @hash[key.to_sym] = key }
    @backend = I18n.backend
  end

  it 'should pluralize correctly' do
    @backend.send(:pluralize, :cs, @hash, 1).should eq('one')
    @backend.send(:pluralize, :cs, @hash, 2).should eq('few')
    @backend.send(:pluralize, :cs, @hash, 3).should eq('few')
    @backend.send(:pluralize, :cs, @hash, 5).should eq('many')
    @backend.send(:pluralize, :cs, @hash, 10).should eq('many')
    @backend.send(:pluralize, :cs, @hash, 11).should eq('many')
    @backend.send(:pluralize, :cs, @hash, 21).should eq('one')
    @backend.send(:pluralize, :cs, @hash, 29).should eq('many')
    @backend.send(:pluralize, :cs, @hash, 52).should eq('few')
    @backend.send(:pluralize, :cs, @hash, 131).should eq('one')
    @backend.send(:pluralize, :cs, @hash, 1.31).should eq('other')
    @backend.send(:pluralize, :cs, @hash, 2.31).should eq('other')
    @backend.send(:pluralize, :cs, @hash, 3.31).should eq('other')
  end
end
