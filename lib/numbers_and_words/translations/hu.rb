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

      def hundreds(number, options = {})
        super number, options.merge(separator: '')
      end
    end
  end
end
