# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Decorators
        # The fractional part digit by digit, including leading zeros, as in Finnish and Norwegian.
        module Digits
          # Finnish reads the fractional part digit by digit, including leading zeros.
          class Fractional < Base
            def run
              length = @options[:fractional][:length].to_i
              digits = @strategy.figures.reverse.join.rjust(length, '0')
              digits.chars.map { |digit| @strategy.translations.t(:ones)[digit.to_i] }.join(' ')
            end
          end
        end
      end
    end
  end
end
