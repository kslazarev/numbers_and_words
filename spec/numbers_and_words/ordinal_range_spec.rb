# frozen_string_literal: true

require 'spec_helper'

describe 'ordinal: {minimum:, maximum:}' do # rubocop:disable RSpec/DescribeClass -- checks a range declared in a locale file
  after { I18n.reload! }

  it 'raises for ordinals outside a range declared after the options were read' do
    I18n.with_locale(:en) do
      expect(100.to_words(ordinal: true)).to eq('one hundredth')
      I18n.backend.store_translations(:en, numbers: { supported_options: { ordinal: { minimum: 1, maximum: 99 } } })
      expect(99.to_words(ordinal: true)).to eq('ninety-ninth')
      expect { 100.to_words(ordinal: true) }.to raise_error(RangeError, 'Ordinals in :en only support numbers between 1 and 99.')
      expect(100.to_words).to eq('one hundred')
    end
  end

  it 'raises only below a minimum declared alone' do
    I18n.with_locale(:en) do
      expect(0.to_words(ordinal: true)).to eq('zeroth')
      I18n.backend.store_translations(:en, numbers: { supported_options: { ordinal: { minimum: 1 } } })
      expect(1.to_words(ordinal: true)).to eq('first')
      expect((10**30).to_words(ordinal: true)).to eq('one nonillionth')
      expect { 0.to_words(ordinal: true) }.to raise_error(RangeError, 'Ordinals in :en only support numbers from 1.')
    end
  end
end
