module NumbersAndWords
  module TranslationsHelpers
    module Es
      include NumbersAndWords::TranslationsHelpers::Base
      include NumbersAndWords::TranslationsHelpers::Families::Latin

      TENS_CASE = 2

      def translation_ones number
        t(:ones)[number]
      end

      def translation_tens( numbers, alone=true )
        (numbers == TENS_CASE && alone) ? t(:twenty) : super( numbers )
      end

      def translation_tens_with_ones numbers
        inter = numbers[1]==TENS_CASE ? "" : " y "
        [translation_tens(numbers[1], false), translation_ones(numbers[0])].join( inter )
      end

      def translation_hundreds number, is_100=false
        is_100 ? t(:one_hundred) : t(:hundreds)[number-1]
      end

      def translation_megs capacity, is_one=false
        is_one ? t(:mega)[capacity] : t(:megas)[capacity] 
      end

    end

  end
end
