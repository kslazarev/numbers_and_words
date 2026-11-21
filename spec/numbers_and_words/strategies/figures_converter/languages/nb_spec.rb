# frozen_string_literal: true

require 'spec_helper'

describe NumbersAndWords::Strategies::FiguresConverter::Languages::Nb do
  around { |example| I18n.with_locale(:nb) { example.run } }

  it 'raises for numbers from 10**21' do
    expect { (10**21).to_words }.to raise_error(RangeError, 'Norwegian numbers must be below 10**21')
  end

  it 'is the language of no, nb-NO and no-NO' do
    expect(%i[no nb-NO no-NO].map { |code| NumbersAndWords::I18n.local_language(code) }).to eq(%i[nb nb nb])
  end
end
