# frozen_string_literal: true

module NumbersAndWords
  module Translations
    class Vi < Base
      include NumbersAndWords::Translations::Families::Latin
      include NumbersAndWords::Translations::Extensions::FractionSignificance
      def ones_of_tens(number, options = {})
        return t('units.tens.one') if number == 1
        return t('units.tens.five') if number == 5

        ones(number, options)
      end

      def tens_with_ones(numbers, options = {})
        [tens(numbers[1]), ones_of_tens(numbers[0], options)].join options[:separator] || ' '
      end

      def ones_union(number, options = {})
        [t(:ones_union), ones(number, options)].join options[:separator] || ' '
      end
    end
  end
end
