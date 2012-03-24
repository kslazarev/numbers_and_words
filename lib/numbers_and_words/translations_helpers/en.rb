module NumbersAndWords
  module TranslationsHelpers
    module En
      include NumbersAndWords::TranslationsHelpers::Base

      private

      def translation_teens number
        t(:teens)[number]
      end

      def translation_tens number
        t(:tens)[number]
      end

      def translation_ones number
        t(:ones)[number]
      end

      def translation_tens_with_ones numbers
        [translation_tens(numbers[1]), translation_ones(numbers[0])].join '-'
      end

      def translation_union
        t :union
      end

      def translation_hundreds number
        [t(:ones)[number], t(:hundreds)].join ' '
      end

      def translation_megs capacity
        t(:mega)[capacity]
      end
      
      def translation_mega capacity
        t(:mega)[capacity]
      end
      
      def zero
        t(:ones)[0]
      end
    end
  end
end
