# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Decorators
        module Sk
          # Slovak reads the integral part of a decimal in the female gender, followed by its noun: "dvadsaťjedna celých".
          class Integral < Base
            def run
              @options[:gender] = :female
              number = @strategy.figures.reverse.join.to_i
              return super if @options[:remove_zero] && number.zero?

              "#{super} #{@strategy.translations.integral(number)}"
            end
          end
        end
      end
    end
  end
end
