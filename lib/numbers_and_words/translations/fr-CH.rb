# frozen_string_literal: true

module NumbersAndWords
  module Translations
    class FrCh < Base
      include NumbersAndWords::Translations::Families::Latin
      include NumbersAndWords::Translations::Extensions::FractionSignificance

      def tens(number, options = {})
        super
      end

      def tens_with_ones(numbers, options = {})
        separator = numbers.first == 1 ? " #{union} " : '-'
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
