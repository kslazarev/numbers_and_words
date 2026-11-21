# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Decorators
        module Ko
          # Korean reads the fractional part digit by digit: 3.14 is 삼 점 일사.
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
