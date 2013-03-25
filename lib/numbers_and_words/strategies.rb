require 'numbers_and_words/strategies/figures_converter'
require 'numbers_and_words/strategies/array_joiner'

module NumbersAndWords
  module Strategies
    class << self
      def figures_converter
        FiguresConverter::Base
      end

      def array_joiner
        ArrayJoiner::Base
      end
    end
  end
end