# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Decorators
        # A count in the feminine and the fraction word in the form for it, as Czech "dvě desetiny", Spanish "dos décimas" and
        # Russian "две десятых".
        module CountedFraction
          class Fractional < Base
            def run
              "#{super} #{fraction_significance}"
            end
          end
        end
      end
    end
  end
end
