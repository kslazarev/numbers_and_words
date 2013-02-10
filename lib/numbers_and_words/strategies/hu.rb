module NumbersAndWords
  module Strategies
    class Hu < Base
      include Families::Latin
      include Extensions::FractionSignificance
      include NumbersAndWords::TranslationsHelpers::Hu

      private

      def with_fraction
        [integer_part, fraction_separator, fractional_part].join(' ')
      end

      def integer_part
        if ordinal?
          words.empty? && zeroth || as_ordinal
        else
          words.empty? && zero || inner_reversed
        end
      end

      def fractional_part
        significance, *words = fraction_words
        fraction = inner_reversed words, fraction_figures
        [fraction, significance].join ' '
      end

      def inner_reversed words = words, figures = figures
        inner_reverse(words).reverse.join(greater_than_2000?(figures) && '-' || '')
      end

      def inner_reverse words = words
        words.collect { |iteration| iteration.reverse.join }
      end

      def greater_than_2000? figures = figures
        figures.length > 4 || (figures.length == 4 && figures.last >= 2)
      end

      def strings
        if figures.capacity_count
          number_without_capacity_to_words + complex_number_to_words
        elsif figures.hundreds
          [hundreds_number_to_words]
        elsif figures.tens or figures.ones
          [simple_number_to_words]
        else
          []
        end
      end

      def complex_number_to_words
        count = figures.capacity_count
        (1..count).map { |capacity| capacity_iteration(capacity).flatten }.reject(&:empty?)
      end

      def simple_number_to_words
        if figures.teens || figures.tens
          [complex_tens]
        elsif figures.ones
          [translation_ones(figures.ones)]
        else
          []
        end
      end

      def as_ordinal
        inner_reversed words[1..-1].unshift(words[0][1..-1].unshift ordinal)
      end

      def ordinal
        if figures.teens || (figures.tens && figures.ones)
          translation_ordinal_tens_with_ones(figures.tens_with_ones)
        elsif figures.ones
          translation_ordinal_ones(figures.ones)
        elsif figures.tens
          translation_ordinal_tens(figures.tens)
        elsif figures.hundreds
          translation_ordinal_hundreds(figures.hundreds)
        else
          translation_ordinal_megs(figures.ordinal_capacity)
        end
      end
    end
  end
end
