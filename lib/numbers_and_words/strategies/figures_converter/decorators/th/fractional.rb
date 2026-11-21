# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Decorators
        module Th
          # Thai reads the fractional part digit by digit: 3.14 is สามจุดหนึ่งสี่.
          class Fractional < Base
            def run
              length = @options[:fractional][:length].to_i
              digits = @strategy.figures.reverse.join.rjust(length, '0')
              digits.chars.map { |digit| @strategy.translations.ones(digit.to_i) }.join
            end
          end
        end
      end
    end
  end
end
