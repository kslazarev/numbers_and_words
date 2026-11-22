# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Decorators
        # The decimal word and each digit, or the fraction word with fraction: true, as in French and Brazilian Portuguese.
        module PointOrFraction
          class Fractional < Base
            include DecimalPoint

            def run
              return decimal_point_words(super) unless fraction?

              "#{super} #{fraction_significance}"
            end
          end
        end
      end
    end
  end
end
