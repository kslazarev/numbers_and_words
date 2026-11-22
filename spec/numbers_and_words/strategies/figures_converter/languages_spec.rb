# frozen_string_literal: true

require 'spec_helper'

describe NumbersAndWords::Strategies::FiguresConverter::Languages do
  after { I18n.reload! }

  it 'defines a class that only includes RuleSets for a language without one of its own' do
    expect(described_class::Sv.ancestors).to include(described_class::RuleSets)
    expect(described_class::Sv.superclass).to eq(described_class::Base)
  end

  it 'keeps the ordinal of zero with remove_zero where the locale file declares it' do
    I18n.with_locale(:en) do
      expect(0.to_words(ordinal: true, remove_zero: true)).to eq('')
      I18n.backend.store_translations(:en, numbers: { supported_options: { remove_zero: { keeps_ordinal_zero: true } } })
      expect(0.to_words(ordinal: true, remove_zero: true)).to eq('zeroth')
    end
  end

  it 'spells with the cardinal rule set where the locale file has none for the gender' do
    I18n.with_locale(:es) { expect(21.to_words(gender: :female)).to eq('veintiuna') }
  end
end
