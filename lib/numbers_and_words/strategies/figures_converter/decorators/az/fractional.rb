# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Decorators
        module Az
          # Azerbaijani names the denominator first, in the locative case: 3.14 is "üç tam yüzdə on dörd",
          # three wholes and fourteen in a hundred.
          class Fractional < Base
            def run
              "#{fraction_significance(nil)} #{super}"
            end
          end
        end
      end
    end
  end
end
