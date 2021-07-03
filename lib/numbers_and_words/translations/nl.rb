# frozen_string_literal: true

module NumbersAndWords
  module Translations
    class Nl < Base
      include NumbersAndWords::Translations::Families::Latin

      def tens_with_ones(numbers, _options = {})
        [ones(numbers[0]), tens(numbers[1])].join(union(numbers[0]))
      end

      def hundreds(number, _options = {})
        return t(:hundreds) if number == 1

        super number, separator: ''
      end

      private

      def union(units)
        return t :union2or3 if [2, 3].include?(units)

        t :union
      end
    end
  end
end
