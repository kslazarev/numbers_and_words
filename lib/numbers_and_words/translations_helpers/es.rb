module NumbersAndWords
  module TranslationsHelpers
    module Es
      include NumbersAndWords::TranslationsHelpers::Base
      include NumbersAndWords::TranslationsHelpers::Families::Latin

      def translation_tens_with_ones numbers
        super numbers, ' y '
      end

    end
  end
end
