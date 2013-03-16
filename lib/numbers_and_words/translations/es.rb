module NumbersAndWords
  module Translations
    class Es < Base
      include NumbersAndWords::Translations::Families::Latin

      TENS_CASE = 2

      def one options = {}
        t(:one)
      end

      def ones number, options = {}
        t(:ones)[number]
      end

      def tens numbers, options = {}
        options[:alone] = true if options[:alone].nil?
        (numbers == TENS_CASE && options[:alone]) ? t(:twenty) : super(numbers)
      end

      def tens_with_ones numbers, options = {}
        inter = numbers[1] == TENS_CASE ? "" : " y "
        [tens(numbers[1], :alone => false), ones(numbers[0])].join inter
      end

      def hundreds number, options = {}
        options[:is_hundred] = false if options[:is_hundred].nil?
        options[:is_hundred] ? t(:one_hundred) : t(:hundreds)[number - 1]
      end

      def megs capacity, options = {}
        options[:is_one] = false if options[:is_one].nil?
        options[:is_one] ? t(:mega)[capacity] : t(:megas)[capacity]
      end
    end
  end
end
