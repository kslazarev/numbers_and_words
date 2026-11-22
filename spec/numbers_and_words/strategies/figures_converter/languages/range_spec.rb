# frozen_string_literal: true

require 'spec_helper'

describe 'Indonesian, Malay, Romanian and Greek limits' do # rubocop:disable RSpec/DescribeClass -- covers four languages
  { id: 15, ms: 15, ro: 18, el: 15 }.each do |locale, power|
    it "raises for #{locale} numbers from 10**#{power}" do
      I18n.with_locale(locale) do
        expect(((10**power) - 1).to_words).not_to be_empty
        expect { (10**power).to_words }.to raise_error(RangeError, "Numbers in #{locale.inspect} only support values below 10**#{power}.")
      end
    end
  end

  it 'raises for Greek ordinals from 10,000' do
    I18n.with_locale(:el) do
      expect(9999.to_words(ordinal: true)).to eq('εννεακισχιλιοστό εννιακοσιοστό ενενηκοστό ένατο')
      expect { 10_000.to_words(ordinal: true) }.to raise_error(RangeError, 'Ordinals in :el only support numbers between 0 and 9999.')
    end
  end

  it 'rejects gender in Indonesian and Malay' do
    %i[id ms].each do |locale|
      expect { I18n.with_locale(locale) { 1.to_words(gender: :female) } }.to raise_error(NumbersAndWords::UnsupportedOptionError)
    end
  end
end
