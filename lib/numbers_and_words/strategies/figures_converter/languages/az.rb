# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        # Azerbaijani counts like Turkish: "min" alone for one thousand ("bir milyon" for larger scales),
        # and ordinals add a suffix that follows vowel harmony to the last word ("iyirmi birinci").
        class Az < Base
          prepend Ordinals

          def capacity_iteration
            words = []
            capacity_words = words_in_capacity(@current_capacity)
            words.push(megs) unless capacity_words.empty?
            words += capacity_words unless thousand? && one?
            words
          end

          def zero(*)
            @options.remove_zero.result ? '' : super
          end

          private

          def one?
            words_in_capacity(@current_capacity) == [translations.ones(1)]
          end

          def thousand?
            @current_capacity == FiguresArray::THOUSAND_CAPACITY
          end

          def ordinal_words(text, _number)
            with_last_word(without_leading_one(text)) { |word| harmonic_ordinal(word) }
          end
        end
      end
    end
  end
end
