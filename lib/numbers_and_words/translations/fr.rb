module NumbersAndWords
  module Translations
    class Fr < Base
      include NumbersAndWords::Translations::Families::Latin

      SPECIAL_TENS_CASE = 8

      def tens number, options = {}
        options[:alone] = true if options[:alone].nil?
        (SPECIAL_TENS_CASE == number and options[:alone]) ? t(:eighty) : super(number)
      end

      def tens_with_ones numbers, options = {}
        if [7, 9].include? numbers[1]
          [tens(numbers[1] - 1, :alone => false), teens(numbers)].join '-'
        else
          union = numbers[0] == 1 ? ' et ' : '-'
          [tens(numbers[1], :alone => false), ones(numbers[0])].join union
        end
      end

      def hundreds number, options = {}
        options[:pluralize] = false if options[:pluralize].nil?
        hundreds = t(:hundreds, :count => options[:pluralize] ? number : 1)
        (number == 1) ? hundreds : [t(:ones)[number], hundreds].join(' ')
      end
    end
  end
end
