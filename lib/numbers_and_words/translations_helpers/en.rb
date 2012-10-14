module NumbersAndWords
  module TranslationsHelpers
    module En
      include NumbersAndWords::TranslationsHelpers::Base
      include NumbersAndWords::TranslationsHelpers::Families::Latin

      def translation_tens_with_ones numbers
        [translation_tens(numbers[1]), translation_ones(numbers[0])].join '-'
      end
    end
  end
end
