module NumbersAndWords
  module Translations
    class Fr < Base
      include NumbersAndWords::Translations::Families::Latin
      include NumbersAndWords::Translations::Extensions::FractionSignificance

      SPECIAL_TENS_CASE = 8

      def tens(number, options = {})
        return t(:eighty) if number == SPECIAL_TENS_CASE && options[:alone].nil?
        super number, options
      end

      def tens_with_ones(numbers, _options = {})
        if [7, 9].include? numbers[1]
          [tens(numbers[1] - 1, alone: false), teens(numbers)].join('-')
        else
          separator = numbers[0] == 1 ? " #{union} " : '-'
          [tens(numbers[1], alone: false), ones(numbers[0])].join(separator)
        end
      end

      def hundreds(number, options = {})
        count = options[:pluralize] ? number : 1
        hundreds = t(:hundreds, count: count)

        return hundreds if number == 1
        [t(:ones)[number], hundreds].join(' ')
      end
    end
  end
end
