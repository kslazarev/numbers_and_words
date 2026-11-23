# frozen_string_literal: true

require 'spec_helper'

describe 'remove_zero option' do # rubocop:disable RSpec/DescribeClass -- checks every language's option classes
  decorators = NumbersAndWords::Strategies::FiguresConverter::Decorators
  with_decimals = NumbersAndWords::I18n.languages.select do |locale|
    decorators.decimals?(locale)
  end

  with_decimals.each do |locale|
    it "is supported in #{locale}, which converts decimals" do
      expect(NumbersAndWords::OptionsValidation.supported_options(locale)).to include(:remove_zero)
    end

    it "omits the zero integral part in #{locale}" do
      I18n.with_locale(locale) do
        expect(0.7.to_words(remove_zero: true)).not_to include(0.to_words)
      end
    end
  end

  it 'leaves no words for the ordinal of zero, or spells it in Russian, Ukrainian, Belarusian, Bulgarian, Macedonian and Slovak' do
    locales = NumbersAndWords::I18n.languages.select { |locale| NumbersAndWords::OptionsValidation.supported_options(locale).key?(:remove_zero) }
    empty, kept = (locales - %i[ar cy ga he]).partition do |locale|
      I18n.with_locale(locale) { 0.to_words(ordinal: true, remove_zero: true) }.empty?
    end
    expect(kept).to include(:ru, :uk, :be, :bg, :mk, :sk)
    expect(empty).to include(:az, :de, :fr, :'fr-CH', :ja, :ko, :nb, :nl, :th, :vi, :zh)
    expect(I18n.with_locale(:ru) { 0.to_words(ordinal: true, remove_zero: true) }).to eq('нулевой')
  end
end
