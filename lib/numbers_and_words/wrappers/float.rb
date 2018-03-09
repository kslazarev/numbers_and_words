# frozen_string_literal: true

module NumbersAndWords
  module Wrappers
    class Float
      ZERO_SYMBOL = '0'

      attr_accessor :number

      def initialize(number)
        @number = number
      end

      def to_words(options = {})
        @options = options
        words = []
        words << integral_part_with(options)
        words << fractional_part_with(options) unless fractional_part_is_nil?
        NumbersAndWords::WordsArray.new(words).join options
      end

      private

      attr_accessor :options

      def parts
        number.to_s.split '.'
      end

      def integral_part
        parts.first
      end

      def fractional_part
        part = parts.last
        part += ZERO_SYMBOL * (precision - part.length) if precision
        part
      end

      def integral_part_with(options)
        integral_part.to_i.to_words options.merge(integral_options)
      end

      def fractional_part_with(options)
        fractional_part.to_i.to_words options.merge(fractional_options)
      end

      def integral_options
        { integral: {} }
      end

      def fractional_options
        length = precision || fractional_part.length
        { fractional: { length: length } }
      end

      def fractional_part_is_nil?
        fractional_part.to_i.zero?
      end

      def precision
        options.fetch(:precision, nil)
      end
    end
  end
end
