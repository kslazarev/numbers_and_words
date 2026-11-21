# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Decorators
        module Bg
          # Bulgarian reads the integral part of a decimal in the neuter gender, followed by its noun: "двадесет и едно цяло".
          class Integral < Base
            def run
              @options[:gender] = :neuter
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
