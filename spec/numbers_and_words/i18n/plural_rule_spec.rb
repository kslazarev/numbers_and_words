# frozen_string_literal: true

require 'spec_helper'

describe NumbersAndWords::I18n::PluralRule do
  def category(rules, count)
    described_class.new(rules).to_proc.call(count)
  end

  it 'gives the first category whose condition holds, or other' do
    rules = { one: 'n % 10 = 1 and n % 100 != 11', few: 'n % 10 = 2,3,4 and n % 100 != 12,13,14' }
    expect([1, 11, 21, 2, 12, 22, 5].map { |count| category(rules, count) }).to eq(%i[one other one few other few other])
  end

  it 'matches a list only at its values and a range between its ends' do
    expect([category({ few: 'n = 2,3,4' }, 2.5), category({ few: 'n = 2..4' }, 2.5)]).to eq(%i[other few])
  end

  it 'joins conditions with or, and reads the absolute integer part and whether a count is an integer' do
    rules = { one: 'v = 0 and i = 1', many: 'n = 0 or n = 5' }
    expect([-1, 1.0, 0, 5, 7].map { |count| category(rules, count) }).to eq(%i[one other many many other])
  end

  it 'rejects a relation it cannot read' do
    expect { described_class.new(one: 'n is 1') }.to raise_error(ArgumentError, 'Invalid plural relation: n is 1')
  end
end
