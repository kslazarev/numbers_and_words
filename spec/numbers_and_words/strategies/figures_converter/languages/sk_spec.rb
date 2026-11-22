# frozen_string_literal: true

require 'spec_helper'

describe NumbersAndWords::Strategies::FiguresConverter::Languages::Sk do
  around { |example| I18n.with_locale(:sk) { example.run } }

  it 'raises for numbers from 10**21' do
    expect { (10**21).to_words }.to raise_error(RangeError, 'Numbers in :sk only support values below 10**21.')
  end

  it 'raises for more than nine fractional digits' do
    expect { 0.5.to_words(precision: 10) }.to raise_error(RangeError, 'Decimals in :sk only support up to 9 fractional digits.')
  end

  it 'chooses the singular, the nominative plural or the genitive plural of a unit' do
    backend = I18n.backend
    I18n.backend = I18n::Backend::Simple.new
    I18n.backend.store_translations(:sk, units: { crown: { one: 'koruna', few: 'koruny', other: 'korún', gender: :female } })
    expect([1, 2, 4, 5, 21, 22].map { |number| number.to_words(unit: :crown) })
      .to eq(['jedna koruna', 'dve koruny', 'štyri koruny', 'päť korún', 'dvadsaťjedna korún', 'dvadsaťdve korún'])
  ensure
    I18n.backend = backend
  end
end
