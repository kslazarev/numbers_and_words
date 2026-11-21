# frozen_string_literal: true

require 'spec_helper'

describe NumbersAndWords::Strategies::FiguresConverter::Languages::He do
  around { |example| I18n.with_locale(:he) { example.run } }

  it 'returns Hebrew letters in logical order without bidirectional control characters' do
    words = [0, 21, 1_001, 123_456, 2_000_000_000, 3.14].map(&:to_words) + [21.to_words(gender: :male)]
    expect(words.join(' ')).to match(/\A[\p{Hebrew} ]+\z/)
    expect(words.first(2)).to eq(%w[אפס] + ['עשרים ואחת'])
  end

  it 'raises for numbers from 10**15' do
    expect { (10**15).to_words }.to raise_error(RangeError, 'Hebrew numbers must be below 10**15')
  end
end
