# frozen_string_literal: true

require 'spec_helper'

# Russian and Ukrainian decline numbers by grammatical case; the fixtures check exact words, and this checks
# that every case and gender gives distinct words for every number.
describe 'case option' do # rubocop:disable RSpec/DescribeClass -- covers Russian and Ukrainian
  let(:numbers) do
    [*0..1100, 1999, 2000, 2001, 2021, 9999, 10_000, 21_000, 99_999, 100_000, 999_999, 1_000_000, 2_000_000,
     2_025_000, 21_000_000, 1_000_000_000, 2_000_000_000, 123_456_789]
  end

  %i[ru uk].each do |locale|
    values = NumbersAndWords::Strategies::FiguresConverter::Options.const_get(locale.capitalize)::Case::VALUES

    values.product(%i[male female neuter]).each do |grammatical_case, gender|
      it "spells every #{locale} #{gender} #{grammatical_case} ordinal" do
        ordinals = I18n.with_locale(locale) do
          numbers.map { |number| number.to_words(ordinal: true, gender:, case: grammatical_case, animate: true) }
        end

        expect(ordinals.grep(/translation missing|\A\s*\z|\b_\b/i)).to eq([])
        expect(ordinals.uniq.size).to eq(numbers.size)
      end

      it "spells every #{locale} #{gender} #{grammatical_case} cardinal" do
        cardinals = I18n.with_locale(locale) do
          numbers.map { |number| number.to_words(gender:, case: grammatical_case, animate: true) }
        end

        expect(cardinals.grep(/translation missing|\A\s*\z|\b_\b/i)).to eq([])
        expect(cardinals.uniq.size).to eq(numbers.size)
      end
    end

    it "declines every word of a cardinal in #{locale}" do
      nominative = I18n.with_locale(locale) { 123_456_789.to_words.split }
      declined = I18n.with_locale(locale) { 123_456_789.to_words(case: :dative).split }

      expect(declined.size).to eq(nominative.size)
      expect(declined.zip(nominative).select { |pair| pair.uniq.size == 1 }).to eq([])
    end

    it "keeps the nominative ordinal by default in #{locale}" do
      I18n.with_locale(locale) do
        expect(21.to_words(ordinal: true, case: :nominative)).to eq(21.to_words(ordinal: true))
        expect(21.to_words(ordinal: true, case: 'genitive')).to eq(21.to_words(ordinal: true, case: :genitive))
      end
    end

    it "uses the inanimate accusative unless animate: true in #{locale}" do
      I18n.with_locale(locale) do
        expect(21.to_words(ordinal: true, case: :accusative)).to eq(21.to_words(ordinal: true))
        expect(21.to_words(ordinal: true, case: :accusative, animate: true)).to eq(21.to_words(ordinal: true, case: :genitive))
        expect(21.to_words(case: :accusative)).to eq(21.to_words)
        expect(2.to_words(case: :accusative, animate: true)).to eq(2.to_words(case: :genitive))
        expect(22.to_words(case: :accusative, animate: true)).to eq(22.to_words)
      end
    end

    it "rejects an unknown case in #{locale}" do
      expect { I18n.with_locale(locale) { 1.to_words(ordinal: true, case: :ablative) } }
        .to raise_error(NumbersAndWords::UnsupportedOptionError, /unsupported value :ablative for option :case/)
    end

    it "rejects case: for decimals in #{locale}" do
      I18n.with_locale(locale) do
        expect { 2.5.to_words(case: :genitive) }.to raise_error(NumbersAndWords::UnsupportedOptionError, /not supported for decimals/)
        expect(2.5.to_words(case: :nominative)).to eq(2.5.to_words)
      end
    end
  end

  it 'rejects case: in other languages' do
    expect { I18n.with_locale(:en) { 1.to_words(case: :genitive) } }.to raise_error(NumbersAndWords::UnsupportedOptionError)
  end
end
