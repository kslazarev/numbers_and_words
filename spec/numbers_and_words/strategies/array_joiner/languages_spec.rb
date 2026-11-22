# frozen_string_literal: true

require 'spec_helper'

describe NumbersAndWords::Strategies::ArrayJoiner::Languages do
  after { I18n.reload! }

  it 'keeps the decimal word with remove_zero where the locale file declares it' do
    I18n.with_locale(:es) do
      expect(0.5.to_words(remove_zero: true)).to eq('cinco décimas')
      I18n.backend.store_translations(:es, numbers: { supported_options: { remove_zero: { keeps_micro_separator: true } } })
      expect(0.5.to_words(remove_zero: true)).to eq('con cinco décimas')
    end
  end

  it 'defines a joiner and translations for a language without its own' do
    expect(described_class::Sv.superclass).to eq(described_class::Base)
    expect(NumbersAndWords::Translations::Sv.superclass).to eq(NumbersAndWords::Translations::Base)
  end
end
