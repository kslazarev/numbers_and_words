module NumbersAndWords
  module Strategies
    class En < Base
      include Families::Latin
      include Extensions::Options::Fractional
      include NumbersAndWords::TranslationsHelpers::En

      def union_elements elements, options = {}
        elements -= [zero]
        super
      end
    end
  end
end
