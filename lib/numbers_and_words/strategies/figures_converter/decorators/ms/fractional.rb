# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Decorators
        module Ms
          # Malay reads the fractional part digit by digit: 3.14 is tiga perpuluhan satu empat.
          class Fractional < Id::Fractional
          end
        end
      end
    end
  end
end
