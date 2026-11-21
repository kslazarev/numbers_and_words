# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        class Lt < Base
          prepend Ordinals

          def capacity_iteration
            words = []
            capacity_words = words_in_capacity(@current_capacity)
            words.push(megs) unless capacity_words.empty?
            words += capacity_words unless thousand? && one?
            words
          end

          def megs
            super({ number: @figures.number_in_capacity(@current_capacity) })
          end

          private

          def one?
            words_in_capacity(@current_capacity) == [translations.ones(1)]
          end

          def thousand?
            @current_capacity == FiguresArray::THOUSAND_CAPACITY
          end

          # Only the last word is ordinal ("dvidešimt pirmas"); scale words take -inis ("milijoninis").
          def ordinal_words(text, _number)
            with_last_word(without_leading_one(text)) do |word|
              lookup(ordinals[:words], word) || replace_suffix(word, ordinals[:suffixes]) ||
                "#{ordinals[:scale_endings].reduce(word) { |stem, ending| stem.delete_suffix(ending) }}#{ordinals[:scale_suffix]}"
            end
          end
        end
      end
    end
  end
end
