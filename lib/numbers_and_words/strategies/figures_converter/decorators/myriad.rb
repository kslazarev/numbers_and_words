# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Decorators
        # The fractional part digit by digit, in the language's script, as in Chinese, Japanese and Korean.
        module Myriad
          # Chinese reads the fractional part digit by digit: 3.14 is 三点一四.
          class Fractional < Base
            def run
              @strategy.language.fractional_words(@options[:fractional][:length].to_i)
            end
          end
        end
      end
    end
  end
end
