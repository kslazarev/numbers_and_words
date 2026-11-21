# frozen_string_literal: true

module NumbersAndWords
  module Translations
    class Hu < Base
      include NumbersAndWords::Translations::Families::Latin
      include NumbersAndWords::Translations::Extensions::FractionSignificance

      def tens_with_ones(numbers, options = {})
        ones, tens = numbers
        [t(:tens_with_ones)[tens], t([options[:prefix], :ones_with_tens].join('.'))[ones]].join
      end

      # "száz" and "kétszáz" rather than "egyszáz" and "kettőszáz".
      def hundreds(number, options = {})
        [compound_ones(number), t([options[:prefix], :hundreds].join('.'))].join
      end

      # The form of a digit at the start of a compound: none for one, "két" for two.
      def compound_ones(number)
        return '' if number == 1
        return t(:compound_two) if number == 2

        t(:ones)[number]
      end
    end
  end
end
