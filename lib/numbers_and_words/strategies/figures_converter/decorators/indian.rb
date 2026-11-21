# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Decorators
        # Decimals in the Indian numbering system, shared by Hindi, Bengali and Urdu.
        module Indian
          # The fractional part is read digit by digit, including leading zeros: 3.05 is "तीन दशमलव शून्य पाँच".
          class Fractional < Decorators::Base
            def run
              length = @options[:fractional][:length].to_i
              digits = @strategy.figures.reverse.join.rjust(length, '0')
              digits.chars.map { |digit| @strategy.translations.ones(digit.to_i) }.join(' ')
            end
          end
        end
      end
    end
  end
end
