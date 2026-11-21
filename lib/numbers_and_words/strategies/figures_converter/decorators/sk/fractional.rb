# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Decorators
        module Sk
          # Slovak reads the fractional part as a feminine number of tenths, hundredths and so on.
          class Fractional < Base
            def run
              @options[:gender] = :female
              length = @options[:fractional][:length].to_i
              "#{super} #{@strategy.translations.fraction(length, @strategy.figures.reverse.join.to_i)}"
            end
          end
        end
      end
    end
  end
end
