# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Decorators
        module De
          # German reads the digits after the decimal comma one at a time,
          # including leading zeros: 3,05 is "drei Komma null fünf".
          class Fractional < Base
            def run
              digits.map { |digit| @strategy.translations.ones(digit, postfix: :default) }.join(' ')
            end

            private

            def digits
              figures = @strategy.figures.reverse
              ([0] * (fraction_length - figures.length)) + figures
            end

            def fraction_length
              @options[:fractional][:length].to_i
            end
          end
        end
      end
    end
  end
end
