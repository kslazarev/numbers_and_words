# frozen_string_literal: true

require 'spec_helper'

describe NumbersAndWords::Strategies::FiguresConverter::Languages::Mk do
  around { |example| I18n.with_locale(:mk) { example.run } }

  it 'raises for numbers from 10**36' do
    expect { (10**36).to_words }.to raise_error(RangeError, 'Numbers in :mk only support values below 10**36.')
  end

  it 'reads more than three decimal places digit by digit after the leading zeros' do
    expect(0.0105.to_words).to eq('нула кома нула еден нула пет')
  end
end
