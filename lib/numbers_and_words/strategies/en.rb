module NumbersAndWords
  module Strategies
    class En < Base
      include Families::Latin
      include Extensions::FractionSignificance
      include NumbersAndWords::TranslationsHelpers::En

      private

      def with_fraction
        british_fraction_with_zero? ? british_fraction_with_zero : super
      end

      def fraction_strings
        british_fraction? ? british_fractional_part : super
      end

      def british_fractional_part
        fraction_figures.map { |f| translation_ones f }
      end

      def fraction_separator
        options[:fraction_separator] || translation_fraction_separator(options.merge :british => british_fraction?)
      end

      def british_fraction?
        options[:british_fraction]
      end

      def british_fraction_with_zero
        [fraction_separator, fractional_part].join ' '
      end

      def british_fraction_with_zero?
        words.empty? && !zero_with_fraction? && british_fraction?
      end
    end
  end
end
