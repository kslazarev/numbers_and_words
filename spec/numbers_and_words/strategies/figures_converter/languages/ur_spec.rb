# frozen_string_literal: true

require 'spec_helper'

describe NumbersAndWords::Strategies::FiguresConverter::Languages::Ur do
  around { |example| I18n.with_locale(:ur) { example.run } }

  it 'returns Urdu letters in logical order without bidirectional control characters' do
    words = [0, 21, 1_001, 12_345_678, 10**12, 3.14].map(&:to_words) + [5.to_words(ordinal: true, gender: :female)]
    expect(words.join(' ')).to match(/\A[\p{Arabic} ]+\z/)
    expect(words.first(2)).to eq(%w[صفر اکیس])
  end

  it 'uses Urdu rather than Arabic letters' do
    words = (0..99).map(&:to_words).join(' ')
    expect(words).not_to match(/[كهي]/)
  end
end
