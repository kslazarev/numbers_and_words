# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Decorators
        module Zh
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
