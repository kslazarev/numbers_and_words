# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Decorators
        module He
          # Hebrew reads the fractional part digit by digit in the feminine form: 3.14 is שלוש נקודה אחת ארבע.
          class Fractional < Base
            def run
              length = @options[:fractional][:length].to_i
              digits = @strategy.figures.reverse.join.rjust(length, '0')
              digits.chars.map { |digit| @strategy.translations.ones(digit.to_i, :female) }.join(' ')
            end
          end
        end
      end
    end
  end
end
