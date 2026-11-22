# frozen_string_literal: true

require 'spec_helper'

describe NumbersAndWords::Strategies::FiguresConverter::Languages::Fi do
  around { |example| I18n.with_locale(:fi) { example.run } }

  it 'raises for numbers from 10**15' do
    expect { (10**15).to_words }.to raise_error(RangeError, 'Numbers in :fi only support values below 10**15.')
  end
end
