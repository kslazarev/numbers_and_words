module NumbersAndWords
  module Translations
    class Fr < Base
      include NumbersAndWords::Translations::Families::Latin

      SPECIAL_TENS_CASE = 8

      def tens number, alone = true
        (SPECIAL_TENS_CASE == number and alone) ? t(:eighty) : super(number)
      end

      def tens_with_ones numbers
        if [7, 9].include? numbers[1]
          [tens(numbers[1] - 1, false), teens(numbers[0])].join '-'
        else
          union = numbers[0] == 1 ? ' et ' : '-'
          [tens(numbers[1], false), ones(numbers[0])].join union
        end
      end

      def hundreds number, pluralize = false
        hundreds = t(:hundreds, :count => pluralize ? number : 1)
        (number == 1) ? hundreds : [t(:ones)[number], hundreds].join(' ')
      end
    end
  end
end
