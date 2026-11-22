# frozen_string_literal: true

require 'spec_helper'

describe 'Indian numbering' do # rubocop:disable RSpec/DescribeClass -- covers Hindi, Bengali and Urdu
  { hi: 'एक करोड़', bn: 'এক কোটি', ur: 'ایک کروڑ' }.each do |locale, crore|
    it "has a distinct word for every number below 100 and groups larger #{locale} numbers by two digits" do
      I18n.with_locale(locale) do
        expect((0..99).map(&:to_words).uniq.size).to eq(100)
        expect(10_000_000.to_words).to eq(crore)
        # 99,99,999 is "ninety-nine lakh ninety-nine thousand nine hundred ninety-nine".
        expect(9_999_999.to_words.split.size).to eq(locale == :bn ? 6 : 7)
      end
    end
  end

  it 'repeats the largest scale word for larger numbers' do
    expect(I18n.with_locale(:bn) { (10**14).to_words }).to eq('এক কোটি কোটি')
    expect(I18n.with_locale(:hi) { (10**22).to_words }).to eq('एक खरब खरब')
  end
end
