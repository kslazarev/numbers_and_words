module NumbersAndWords
  module Strategies
    class Base
      attr_accessor :figures, :fraction_figures, :options, :words, :fraction_words

      def self.factory
        "NumbersAndWords::Strategies::#{::I18n.locale.to_s.titleize}".constantize.new
      end

      def convert figures, options = {}
        @figures = figures.integer_part.reverse
        @fraction_figures = figures.fractional_part.reverse
        @options = options
        @words = strings
        @fraction_words = fraction_strings

        fraction_words.empty? && integer_part || with_fraction
      end

      private

      def with_fraction
        return fractional_part if words.empty? && !zero_with_fraction?
        [integer_part, fraction_separator, fractional_part].join ' '
      end

      def integer_part
        words.empty? && zero || words.reverse.join(' ')
      end

      def fractional_part
        fraction_words.reverse.join(' ')
      end

      def fraction_separator
        options[:fraction_separator] || translation_fraction_separator(options)
      end

      def zero_with_fraction?
        options[:zero_with_fraction]
      end
    end
  end
end
