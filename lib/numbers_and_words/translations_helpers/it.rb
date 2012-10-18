module NumbersAndWords
  module TranslationsHelpers
    module It
      include NumbersAndWords::TranslationsHelpers::Base
      include NumbersAndWords::TranslationsHelpers::Families::Latin

      def translation_tens_with_ones numbers
        [translation_tens(numbers[1]), translation_ones(numbers[0])].join ''
      end

      def translation_hundreds number
        [[number], t(:hundreds)].join ' '
      end
    end
  end
end
