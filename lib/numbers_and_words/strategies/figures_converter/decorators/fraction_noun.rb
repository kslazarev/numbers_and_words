# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Decorators
        # A decimal read as two counted nouns, as Bulgarian "едно цяло и две десети" and Slovak "jedna celá a dve
        # desatiny", in the genders under numbers.decimals in the locale file.
        module FractionNoun
          # The integral part and its noun, which remove_zero leaves out with a zero integral part.
          class Integral < Base
            def run
              number = @strategy.figures.reverse.join.to_i
              return super if @options[:remove_zero] && number.zero?

              "#{super} #{@strategy.translations.integral(number)}"
            end
          end

          # The fractional part and the fraction noun for its length, such as tenths or hundredths.
          class Fractional < Base
            def run
              length = @options[:fractional][:length].to_i
              "#{super} #{@strategy.translations.fraction(length, @strategy.figures.reverse.join.to_i)}"
            end
          end
        end
      end
    end
  end
end
