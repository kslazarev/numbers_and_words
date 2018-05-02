# frozen_string_literal: true

require 'spec_helper'

describe I18n, 'fr' do
  before(:each) do
    @hash = {}
    %w[one other].each { |key| @hash[key.to_sym] = key }
    @backend = I18n.backend
  end

  it 'should pluralize correctly' do
    expect(@backend.send(:pluralize, :fr, @hash, 1)).to eq('one')
    expect(@backend.send(:pluralize, :fr, @hash, 2)).to eq('other')
    expect(@backend.send(:pluralize, :fr, @hash, 3)).to eq('other')
    expect(@backend.send(:pluralize, :fr, @hash, 5)).to eq('other')
    expect(@backend.send(:pluralize, :fr, @hash, 10)).to eq('other')
    expect(@backend.send(:pluralize, :fr, @hash, 11)).to eq('other')
    expect(@backend.send(:pluralize, :fr, @hash, 21)).to eq('one')
    expect(@backend.send(:pluralize, :fr, @hash, 29)).to eq('other')
    expect(@backend.send(:pluralize, :fr, @hash, 131)).to eq('one')
    expect(@backend.send(:pluralize, :fr, @hash, 1.31)).to eq('other')
    expect(@backend.send(:pluralize, :fr, @hash, 2.31)).to eq('other')
    expect(@backend.send(:pluralize, :fr, @hash, 3.31)).to eq('other')
  end
end
