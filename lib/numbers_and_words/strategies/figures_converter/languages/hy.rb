# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        class Hy < Base
          prepend Ordinals

          # A thousands group of one is just the scale word ("հազար").
          def capacity_iteration
            return [megs] if @current_capacity == FiguresArray::THOUSAND_CAPACITY && @figures.number_in_capacity(@current_capacity) == 1

            super
          end

          private

          # 1 to 4 have their own ordinals; otherwise the last word takes -երորդ, and a final ը becomes ն
          # before it ("քսանմեկերորդ", "իններորդ").
          def ordinal_words(text, number)
            return ordinals[:first_four][number - 1] if number.between?(1, 4)

            with_last_word(without_leading_one(text)) { |word| "#{ordinal_stem(word)}#{ordinals[:suffix]}" }
          end

          def ordinal_stem(word)
            schwa = ordinals[:schwa]
            word.end_with?(schwa) ? "#{word.delete_suffix(schwa)}#{ordinals[:linking]}" : word
          end
        end
      end
    end
  end
end
