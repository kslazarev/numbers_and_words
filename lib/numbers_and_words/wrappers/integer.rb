# frozen_string_literal: true

module NumbersAndWords
  module Wrappers
    class Integer
      attr_accessor :number

      def initialize(number)
        @number = number
      end

      def to_words(options = {})
        to_figures_array.to_words options
      end

      private

      def to_figures_array
        figures = number.abs.digits.reverse
        # Keep the legacy sign-as-zero layout for locale compatibility.
        figures.unshift(0) if number.negative?
        figures.to_figures
      end
    end
  end
end
