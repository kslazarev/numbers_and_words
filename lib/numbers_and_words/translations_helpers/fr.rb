module NumbersAndWords
  module TranslationsHelpers
    module Fr
      include NumbersAndWords::TranslationsHelpers::Base

      private

      def translation_teens number
        t(:teens)[number]
      end

      def translation_tens_alone number
        if number == 8
          t(:eighty)
        else
          translation_tens number
        end
      end

      def translation_tens number
        t(:tens)[number]
      end

      def translation_ones number
        t(:ones)[number]
      end

      def translation_tens_with_ones numbers
        if [7, 9].include? numbers[1]
          [translation_tens(numbers[1] - 1), translation_teens(numbers[0])].join '-'
        else
          union = numbers[0] == 1 ? ' et ' : '-'
          [translation_tens(numbers[1]), translation_ones(numbers[0])].join union
        end
      end

      def translation_hundreds number, pluralize = false
        hundreds = t :hundreds, :count => pluralize ? number : 1

        if number == 1
          hundreds
        else
          [t(:ones)[number], hundreds].join ' '
        end
      end

      def translation_mega capacity
        t(:mega)[capacity]
      end

      def translation_megs capacity, number
        t translation_mega(capacity), :count => number
      end

      def zero
        t(:ones)[0]
      end
    end
  end
end
