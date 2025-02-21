# frozen_string_literal: true

module NumbersAndWords
  module Translations
    class Fr < Base
      include NumbersAndWords::Translations::Families::Latin
      include NumbersAndWords::Translations::Extensions::FractionSignificance

      SPECIAL_TENS_CASE = 8

      def tens(number, options = {})
        return t(:eighty) if number == SPECIAL_TENS_CASE && options[:alone].nil?

        super
      end

      def tens_with_teens(numbers)
        separator = numbers[1] == 7 && numbers[0] == 1 ? "-#{union}-" : '-'
        [tens(numbers[1] - 1, alone: false), teens(numbers)].join(separator)
      end

      def tens_with_ones(numbers, options = {})
        return tens_with_teens(numbers) if [7, 9].include? numbers[1]

        separator = numbers[0] == 1 && numbers[1] != 8 ? " #{union} " : '-'
        return [tens(numbers[1], alone: false), ones(numbers[0], options)].join separator || ' ' if numbers[1] == 8

        super(numbers, options.merge(separator:))
      end

      def hundreds(number, options = {})
        count = options[:pluralize] ? number : 1
        hundreds = t(:hundreds, count:)

        return hundreds if number == 1

        [t(:ones)[number], hundreds].join(' ')
      end
    end
  end
end
