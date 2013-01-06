module NumbersAndWords
  module TranslationsHelpers
    module Es
      include NumbersAndWords::TranslationsHelpers::Base
      include NumbersAndWords::TranslationsHelpers::Families::Latin

      def translation_tens_with_ones numbers
        super numbers, ''
      end

      def translation_hundreds number
        [[number], t(:hundreds)].join ' '
      end
    end
  end
end
