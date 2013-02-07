module NumbersAndWords
  module TranslationsHelpers
    module Se
      include NumbersAndWords::TranslationsHelpers::Base
      include NumbersAndWords::TranslationsHelpers::Families::Latin

      def translation_tens_with_ones numbers
        super numbers, '-'
      end
    end
  end
end
