# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Decorators
        module It
          class Fractional < Base
            include DecimalPoint

            def run
              return decimal_point_words(super) unless fraction?

              words = normalize_singular_fraction_words(super)
              "#{words} #{fraction_significance}"
            end

            private

            def singular_fraction?
              figures.join.to_i == 1
            end

            def normalize_singular_fraction_words(words)
              return words unless singular_fraction?

              tokens = words.split
              one = @strategy.translations.ones(1)
              singular_one = @strategy.translations.t(:fractional_one)
              tokens[-1] = singular_one if tokens.last == one
              tokens.join(' ')
            end

            def figures
              @strategy.figures.reverse
            end
          end
        end
      end
    end
  end
end
