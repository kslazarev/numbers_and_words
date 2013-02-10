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

      def translation_hundreds number, separator = ''
        super
      end

      def translation_micros capacity, number = nil, separator = ''
        super capacity, nil, separator
      end

      def translation_ordinal_tens_with_ones numbers
        ones, tens = numbers
        [t(:tens_with_ones)[tens], t("ordinals.ones_with_tens")[ones]].join ''
      end

      def translation_ordinal_hundreds number, separator = ''
        super
      end
    end
  end
end
