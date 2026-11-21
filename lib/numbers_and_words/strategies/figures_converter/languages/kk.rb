# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        class Kk < Base
          prepend Ordinals

          # A thousands group of one is just the scale word ("мың").
          def capacity_iteration
            return [megs] if @current_capacity == FiguresArray::THOUSAND_CAPACITY && @figures.number_in_capacity(@current_capacity) == 1

            super
          end

          private

          # Only the last word is ordinal, with a suffix that follows vowel harmony ("жиырма бірінші").
          def ordinal_words(text, _number)
            with_last_word(without_leading_one(text)) { |word| harmonic_ordinal(word) }
          end
        end
      end
    end
  end
end
