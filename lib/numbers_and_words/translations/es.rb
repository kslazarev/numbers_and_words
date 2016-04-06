module NumbersAndWords
  module Translations
    class Es < Base
      include NumbersAndWords::Translations::Families::Latin

      TENS_CASE = 2

      def one
        t(:one)
      end

      def ones(number, _options = {})
        t(:ones)[number]
      end

      def one_twenties
        t(:one_twenties)
      end

      def ones_twenties(number)
        t(:ones_twenties)[number]
      end

      def tens(numbers, options = {})
        options[:alone] = true if options[:alone].nil?
        (numbers == TENS_CASE && options[:alone]) ? t(:twenty) : super(numbers)
      end

      def tens_with_ones(numbers, _options = {})
        union = numbers[1] == TENS_CASE ? '' : " #{t(:union)} "
        ones_number = numbers[1] == TENS_CASE ? ones_twenties(numbers[0]) : ones(numbers[0])
        [tens(numbers[1], alone: false), union, ones_number].join
      end

      def hundreds(number, options = {})
        options[:is_hundred] = false if options[:is_hundred].nil?
        options[:is_hundred] ? t(:one_hundred) : t(:hundreds)[number - 1]
      end

      def thousand
        t(:thousand)
      end
    end
  end
end
