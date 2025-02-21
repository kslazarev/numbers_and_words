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
        number_ones, number_tens = numbers.first(2)
        separator = number_tens == 7 && number_ones == 1 ? "-#{union}-" : '-'
        [tens(number_tens - 1, alone: false), teens(numbers)].join(separator)
      end

      def tens_with_ones(numbers, options = {})
        number_ones, number_tens = numbers
        return tens_with_teens(numbers) if [7, 9].include?(number_tens)

        separator = number_ones == 1 && number_tens != 8 ? " #{union} " : '-'
        if number_tens == 8
          [tens(number_tens, alone: false), ones(number_ones, options)].join(separator)
        else
          super(numbers, options.merge(separator:))
        end
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
