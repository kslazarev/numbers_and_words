# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Decorators
        module En
          class Fractional < Base
            include DecimalPoint

            def run
              return decimal_point_digits unless fraction?

              "#{super} #{fraction_significance}"
            end
          end
        end
      end
    end
  end
end
