# frozen_string_literal: true

require 'spec_helper'

describe NumbersAndWords::Strategies::FiguresConverter::Languages::Be do
  around { |example| I18n.with_locale(:be) { example.run } }

  it 'raises for numbers from 10**36' do
    expect { (10**36).to_words }.to raise_error(RangeError, 'Numbers in :be only support values below 10**36.')
  end

  it 'raises for more than 23 fractional digits' do
    expect { 0.5.to_words(precision: 24) }.to raise_error(RangeError, 'Decimals in :be only support up to 23 fractional digits.')
  end
end
