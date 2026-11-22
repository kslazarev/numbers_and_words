# frozen_string_literal: true

require 'spec_helper'

describe 'declarations in the locale file' do # rubocop:disable RSpec/DescribeClass -- checks what options and decimals declare
  after { I18n.reload! }

  it 'reads the words of an option that is on, and of an option value, under numbers.options' do
    I18n.with_locale(:en) do
      I18n.backend.store_translations(:en, numbers: { supported_options: { loud: true }, options: { loud: { tens: %w[_ TEN TWENTY] } } })
      expect(21.to_words(loud: true)).to eq('TWENTY-one')
      expect(21.to_words).to eq('twenty-one')
    end
  end

  it 'spells with the rule set an option names' do
    I18n.with_locale(:de) do
      I18n.backend.store_translations(:de, numbers: { supported_options: { short: { rules: 'short' } }, rules: { 'cardinal-short': { 0 => 'n{=cardinal}' } } })
      expect(21.to_words(short: true)).to eq('neinundzwanzig')
    end
  end

  it 'spells each part of a decimal in the gender numbers.decimals gives it' do
    I18n.with_locale(:ru) do
      expect(1.5.to_words).to eq('одна целая и пять десятых')
      I18n.backend.store_translations(:ru, numbers: { decimals: { integral_gender: 'male' } })
      expect(1.5.to_words).to eq('один целая и пять десятых')
    end
  end
end
