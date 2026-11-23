# frozen_string_literal: true

require 'spec_helper'

describe I18n, '#ar' do
  it 'pluralizes with the CLDR Arabic categories' do
    rule = NumbersAndWords::I18n::Pluralization.rule(:ar)
    expect([0, 1, 2, 3, 10, 11, 99, 100, 102, 103, 111, 1000].map { |count| rule.call(count) })
      .to eq(%i[zero one two few few many many other other few many other])
  end
end
