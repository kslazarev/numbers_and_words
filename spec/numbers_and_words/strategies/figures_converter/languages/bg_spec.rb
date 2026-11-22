# frozen_string_literal: true

require 'spec_helper'

describe NumbersAndWords::Strategies::FiguresConverter::Languages::Bg do
  around { |example| I18n.with_locale(:bg) { example.run } }

  it 'raises for numbers from 10**21' do
    expect { (10**21).to_words }.to raise_error(RangeError, 'Numbers in :bg only support values below 10**21.')
  end

  it 'raises for more than nine fractional digits' do
    expect { 0.5.to_words(precision: 10) }.to raise_error(RangeError, 'Decimals in :bg only support up to 9 fractional digits.')
  end
end
