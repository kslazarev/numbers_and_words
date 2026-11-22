# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Decorators
        # A count in the feminine and the fraction noun for the length of the fractional part, as Bulgarian "две десети".
        module FractionNoun
          # Bulgarian reads the fractional part as a feminine number of tenths, hundredths and so on.
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
