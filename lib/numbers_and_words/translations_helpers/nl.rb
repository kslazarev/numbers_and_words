module NumbersAndWords
  module TranslationsHelpers
    module Nl
      include NumbersAndWords::TranslationsHelpers::Base
      include NumbersAndWords::TranslationsHelpers::Families::Latin

      private

      def translation_tens_with_ones numbers
        [translation_ones(numbers[0]), translation_tens(numbers[1])].join 'en'
      end

      def translation_hundreds number
        1 == number ? t(:hundreds) : [t(:ones)[number], t(:hundreds)].join
      end
    end
  end
end