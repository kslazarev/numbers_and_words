module NumbersAndWords
  module TranslationsHelpers
    module Families
      module Cyrillic
        include NumbersAndWords::TranslationsHelpers::Families::Base

        private

        def translation_ones number
          gender = figures.is_a_thousand_capacity?(current_capacity) ? :female : :male
          t([:ones, gender].join('_'))[number]
        end

        def translation_tens_with_ones numbers
          [translation_tens(numbers[1]), translation_ones(numbers[0])].join ' '
        end

        def translation_hundreds number
          t(:hundreds)[number]
        end

        def translation_megs capacity
          super(capacity, figures.number_in_capacity(capacity))
        end

        def zero
          t(:ones_male)[0]
        end
      end
    end
  end
end