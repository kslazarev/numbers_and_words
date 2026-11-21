# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Decorators
        module El
          # Up to three decimal places are read as a number after one zero for each leading zero, and longer
          # ones digit by digit.
          class Fractional < Base
            include DecimalPoint

            def run
              decimal_point_words(super)
            end

            private

            def fraction_length
              @options[:fractional][:length].to_i
            end
          end
        end
      end
    end
  end
end
