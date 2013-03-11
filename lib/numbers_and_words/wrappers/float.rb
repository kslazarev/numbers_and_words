module NumbersAndWords
  module Wrappers
    class Float
      attr_accessor :number

      def initialize number
        @number = number
      end

      def to_words options = {}
        to_figures_array.to_words options
      end

      private

      def to_figures_array
        number.to_s.split(//).map(&:to_i).to_figures
      end
    end
  end
end