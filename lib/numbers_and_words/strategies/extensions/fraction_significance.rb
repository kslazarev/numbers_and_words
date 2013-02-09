module NumbersAndWords
  module Strategies
    module Extensions
      module FractionSignificance
        private

        def fraction_strings
          fraction_figures.any? ? super.unshift(fraction_significance).compact : super
        end

        def fraction_significance
          translation_micros fraction_figures.fraction_capacity, fraction_figures.reverse.join.to_i
        end
      end
    end
  end
end
