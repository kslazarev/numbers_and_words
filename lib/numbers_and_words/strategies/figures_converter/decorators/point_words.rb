# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Decorators
        # The decimal word and the fractional part read as a number, as in Greek and Romanian.
        module PointWords
          # Up to three decimal places are read as a number after one zero for each leading zero, and longer
          # ones digit by digit.
          class Fractional < Base
            include DecimalPoint

            def run
              decimal_point_words(super)
            end
          end
        end
      end
    end
  end
end
