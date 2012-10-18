module NumbersAndWords
  module TranslationsHelpers
    module Families
      module Base

        private

        def translation_teens number
          t(:teens)[number]
        end

        def translation_tens number
          t(:tens)[number]
        end

        def translation_tens_with_ones numbers, separator = ' '
          [translation_tens(numbers[1]), translation_ones(numbers[0])].join separator
        end

        def translation_megs capacity, number = nil
          number ? t(translation_mega(capacity), :count => number) : t(:mega)[capacity]
        end

        def translation_mega capacity
          t(:mega)[capacity]
        end
      end
    end
  end
end
