module NumbersAndWords
  module TranslationsHelpers
    module Hu
      include NumbersAndWords::TranslationsHelpers::Base
      include NumbersAndWords::TranslationsHelpers::Families::Latin
      include NumbersAndWords::TranslationsHelpers::Extensions::FractionSignificance

      def translation_tens_with_ones numbers
        ones, tens = numbers
        [t(:tens_with_ones)[tens], translation_ones(ones)].join ''
      end

      def translation_hundreds number
        [t(:ones)[number], t(:hundreds)].join ''
      end

      def translation_micros capacity, number = nil, separator = ''
        super capacity, nil, separator
      end
    end
  end
end
