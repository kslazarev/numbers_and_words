# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Decorators
        module Nl
          class Fractional < Base
            def run
              @strategy.options.options[:fractional_numeral] = true
              "#{super} #{fraction_significance}"
            end
          end
        end
      end
    end
  end
end
