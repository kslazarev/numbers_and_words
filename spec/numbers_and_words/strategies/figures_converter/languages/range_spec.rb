# frozen_string_literal: true

require 'spec_helper'

describe 'Indonesian, Malay, Romanian and Greek limits' do # rubocop:disable RSpec/DescribeClass -- covers four languages
  { id: 36, ms: 36, ro: 36, el: 36 }.each do |locale, power|
    it "raises for #{locale} numbers from 10**#{power}" do
      I18n.with_locale(locale) do
        expect(((10**power) - 1).to_words).not_to be_empty
        expect { (10**power).to_words }.to raise_error(RangeError, "Numbers in #{locale.inspect} only support values below 10**#{power}.")
      end
    end
  end

  it 'spells Greek ordinals up to the largest cardinal' do
    I18n.with_locale(:el) do
      expect([9999, 10_000, 21_000, 2_000_000].map { |number| number.to_words(ordinal: true) })
        .to eq(['εννεακισχιλιοστό εννιακοσιοστό ενενηκοστό ένατο', 'δεκακισχιλιοστό', 'είκοσι ένα χιλιοστό', 'δύο εκατομμυριοστό'])
      expect(((10**36) - 1).to_words(ordinal: true)).to end_with('εννιακοσιοστό ενενηκοστό ένατο')
      expect { (10**36).to_words(ordinal: true) }.to raise_error(RangeError, 'Numbers in :el only support values below 10**36.')
    end
  end

  it 'rejects gender in Indonesian and Malay' do
    %i[id ms].each do |locale|
      expect { I18n.with_locale(locale) { 1.to_words(gender: :female) } }.to raise_error(NumbersAndWords::UnsupportedOptionError)
    end
  end
end
