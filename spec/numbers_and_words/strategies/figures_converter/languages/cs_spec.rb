# frozen_string_literal: true

require 'spec_helper'

describe NumbersAndWords::Strategies::FiguresConverter::Languages::Cs do
  around { |example| I18n.with_locale(:cs) { example.run } }

  it 'reads ordinals of thousands with one word for the thousands' do
    expect(2000.to_words(ordinal: true, gender: :female)).to eq('dvoutisící')
  end

  it 'raises for ordinals of 10,000 or more instead of returning wrong words' do
    expect { 10_000.to_words(ordinal: true) }.to raise_error(RangeError, 'Czech ordinals support numbers below 10,000')
  end

  it 'still converts cardinals of 10,000 or more' do
    expect(21_000.to_words).to eq('dvacet jeden tisíc')
  end
end
