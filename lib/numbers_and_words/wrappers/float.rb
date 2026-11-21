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
        @parts = decimal_string.split('.')
        words = []
        words << integral_part_with(options)
        words << fractional_part_with(options) unless fractional_part_is_nil?
        NumbersAndWords::WordsArray.new(words).join options
      end

      private

      attr_accessor :options

      attr_reader :parts

      def decimal_string
        text = number.to_s
        return text unless text.include?('e')

        mantissa, exponent = text.split('e')
        sign = mantissa.delete_prefix!('-') ? '-' : ''
        integral, fraction = mantissa.split('.')
        digits = (integral + fraction).sub(/0+\z/, '')
        "#{sign}#{place_decimal_point(digits, integral.length + exponent.to_i)}"
      end

      def place_decimal_point(digits, position)
        return "0.#{ZERO_SYMBOL * -position}#{digits}" if position <= 0

        digits.ljust(position + 1, ZERO_SYMBOL).insert(position, '.')
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
        # Internal options (integral, fractional) bypass the public option validation.
        Wrappers::Integer.new(integral_part.to_i).to_words options.merge(integral_options)
      end

      def fractional_part_with(options)
        Wrappers::Integer.new(fractional_part.to_i).to_words options.merge(fractional_options)
      end

      def integral_options
        { integral: {} }
      end

      def fractional_options
        length = precision || fractional_part.length
        { fractional: { length: } }
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
