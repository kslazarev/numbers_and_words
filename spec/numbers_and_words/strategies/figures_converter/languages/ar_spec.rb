# frozen_string_literal: true

require 'spec_helper'

describe NumbersAndWords::Strategies::FiguresConverter::Languages::Ar do
  around { |example| I18n.with_locale(:ar) { example.run } }

  it 'converts the largest supported number' do
    expect(((10**21) - 1).to_words).to start_with('تسعمائة وتسعة وتسعون كوينتليونًا و')
  end

  it 'rejects numbers beyond the largest scale word' do
    expect { (10**21).to_words }.to raise_error(RangeError, 'Numbers in :ar only support values below 10**21.')
  end

  it 'returns words in logical order without bidirectional control characters' do
    expect(1_000_021.to_words).not_to match(/\p{Cf}/)
  end
end
