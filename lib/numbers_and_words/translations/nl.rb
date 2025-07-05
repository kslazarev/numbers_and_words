# frozen_string_literal: true

module NumbersAndWords
  module Translations
    class Nl < Base
      include NumbersAndWords::Translations::Families::Latin
      include NumbersAndWords::Translations::Extensions::FractionSignificance

      def ones(number, options = {})
        # In fractional context, use "een" instead of "één" for number 1
        if number == 1 && options[:fractional_numeral]
          t(:ones)[1] # "een" is at index 1 in the ones array
        else
          super
        end
      end

      def tens_with_ones(numbers, options = {})
        [ones(numbers[0], options), tens(numbers[1])].join(union(numbers[0]))
      end

      def hundreds(number, _options = {})
        return t(:hundreds) if number == 1

        super(number, separator: '')
      end

      private

      def union(units)
        return t :union2or3 if [2, 3].include?(units)

        t :union
      end
    end
  end
end
