# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        class Lv < Base
          prepend Ordinals

          def tens_with_ones
            super(separator: ' ')
          end

          def megs
            super({ number: @figures.number_in_capacity(@current_capacity) })
          end

          private

          # Only the last word is ordinal ("divdesmit pirmais"); scale words take -ais ("miljonais").
          def ordinal_words(text, _number)
            with_last_word(without_leading_one(text)) do |word|
              lookup(ordinals[:words], word) || replace_suffix(word, ordinals[:suffixes]) ||
                "#{word.sub(/[si]\z/, '')}#{ordinals[:scale_suffix]}"
            end
          end
        end
      end
    end
  end
end
