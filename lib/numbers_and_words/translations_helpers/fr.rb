module NumbersAndWords
  module TranslationsHelpers
    module Fr
      include NumbersAndWords::TranslationsHelpers::Base
      include NumbersAndWords::TranslationsHelpers::Families::Latin

      SPECIAL_TENS_CASE = 8

      private

      def translation_tens number, alone = true
        (SPECIAL_TENS_CASE == number and alone) ? t(:eighty) : super(number)
      end

      def translation_tens_with_ones numbers
        if [7, 9].include? numbers[1]
          [translation_tens(numbers[1] - 1, false), translation_teens(numbers[0])].join '-'
        else
          union = numbers[0] == 1 ? ' et ' : '-'
          [translation_tens(numbers[1], false), translation_ones(numbers[0])].join union
        end
      end

      def translation_hundreds number, pluralize = false
        hundreds = t(:hundreds, :count => pluralize ? number : 1)
        (number == 1) ? hundreds : [t(:ones)[number], hundreds].join(' ')
      end

      def translation_megs capacity
        super(capacity, figures.number_in_capacity(capacity))
      end
    end
  end
end
