# frozen_string_literal: true

module NumbersAndWords
  module Wrappers
    class Integer
      attr_accessor :number

      def initialize(number)
        @number = number
      end

      def to_words(options = {})
        Sign.words(number, options) { |value| value.digits.reverse.to_figures.to_words options }
      end
    end
  end
end
