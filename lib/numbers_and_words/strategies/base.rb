module NumbersAndWords
  module Strategies
    class Base
      attr_accessor :figures, :fractional_figures, :options, :words, :fractional_words

      def self.factory
        "NumbersAndWords::Strategies::#{::I18n.locale.to_s.titleize}".constantize.new
      end

      def convert figures, options = {}
        @figures = figures.integer_part.reverse
        @fractional_figures = figures.fractional_part.reverse
        @options = options
        @words = strings
        @fractional_words = fractional_strings

        @fractional_words.empty? && integer_part || with_fractional
      end

      def with_fractional
        [integer_part, (options[:fractional_separator] || 'point'), fractional_part].join(' ')
      end

      def integer_part
        words.empty? && zero || words.reverse.join(' ')
      end

      def fractional_part
        fractional_words.reverse.join(' ')
      end
    end
  end
end
