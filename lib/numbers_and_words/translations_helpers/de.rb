module NumbersAndWords
  module TranslationsHelpers
    module De
      include NumbersAndWords::TranslationsHelpers::Base
      include NumbersAndWords::TranslationsHelpers::Families::Latin

      def translation_tens_with_ones numbers
        super numbers, ' und '
      end

      def translation_hundreds number
        [t(:ones)[number], t(:hundreds, :count => number)]
      end

      def translation_megs capacity
        super(capacity, figures.number_in_capacity(capacity))
      end
    end
  end
end
