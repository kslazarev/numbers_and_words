# frozen_string_literal: true

require 'spec_helper'

describe NumbersAndWords::Strategies::FiguresConverter::Languages::Cs do
  around { |example| I18n.with_locale(:cs) { example.run } }

  it 'reads ordinals of thousands with one word for the thousands' do
    expect(2000.to_words(ordinal: true, gender: :female)).to eq('dvoutisící')
  end

  it 'joins the count of a scale ordinal in its combining form up to the largest cardinal' do
    expect([10_000, 21_000, 200_000, 2_000_000].map { |number| number.to_words(ordinal: true, gender: :male) })
      .to eq(%w[desetitisící dvacetijednatisící dvousettisící dvoumiliontý])
    expect { (10**36).to_words(ordinal: true) }.to raise_error(RangeError, 'Numbers in :cs only support values below 10**36.')
  end

  it 'still converts cardinals of 10,000 or more' do
    expect(21_000.to_words).to eq('dvacet jeden tisíc')
  end
end
