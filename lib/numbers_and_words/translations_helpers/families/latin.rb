module NumbersAndWords
  module TranslationsHelpers
    module Families
      module Latin
        include NumbersAndWords::TranslationsHelpers::Families::Base

        private

        def translation_ones number
          t(:ones)[number]
        end

        def translation_tens_with_ones numbers
          [translation_tens(numbers[1]), translation_ones(numbers[0])].join ' '
        end

        def translation_hundreds number
          [t(:ones)[number], t(:hundreds)].join ' '
        end

        def translation_megs capacity
          t(:mega)[capacity]
        end

        def zero
          t(:ones)[0]
        end
      end
    end
  end
end