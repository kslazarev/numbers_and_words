# frozen_string_literal: true

require 'spec_helper'

describe NumbersAndWords::Strategies::FiguresConverter::Languages::Pl do
  around { |example| I18n.with_locale(:pl) { example.run } }

  it 'rejects unsupported large ordinals instead of returning a wrong cardinal' do
    expect { 1000.to_words(ordinal: true) }.to raise_error(RangeError, /\AOrdinals in :pl only support numbers between/)
  end

  it 'keeps the cardinal form of a decimal with ordinal: true' do
    expect(1.1.to_words(ordinal: true)).to eq(1.1.to_words)
  end

  it 'rejects an unsupported grammatical gender' do
    expect { 2.to_words(gender: :unknown) }.to raise_error(ArgumentError, /gender/)
  end

  it 'rejects numbers beyond the translated scale table' do
    expect { (10**48).to_words }.to raise_error(RangeError, 'Numbers in :pl only support values below 10**48.')
  end

  it 'rejects fractions beyond the translated scale table' do
    expect { 0.1.to_words(precision: 49) }.to raise_error(RangeError, 'Decimals in :pl only support up to 48 fractional digits.')
  end

  it 'supports the documented maximum decimal precision' do
    expect(0.1.to_words(precision: 48, remove_zero: true)).to eq('sto septyliardów oktylionowych')
  end

  it 'converts small floats whose Ruby representation uses scientific notation' do
    expect(1.0e-5.to_words(remove_zero: true)).to eq('jedna stutysięczna')
  end

  it 'converts the full magnitude of large scientific-notation floats' do
    expect(1.0e20.to_words).to eq('sto trylionów całych')
  end

  it 'keeps caller options unchanged during decimal conversion' do
    options = { remove_zero: true, gender: :neuter }.freeze
    expect(0.1.to_words(options)).to eq('jedna dziesiąta')
  end
end
