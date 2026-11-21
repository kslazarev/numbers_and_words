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

          # A hundred is simts on its own and simt before another word ("simt viens", "simt tūkstoši").
          def print_words
            hundred = translations.t(:hundreds)[1]
            super.gsub(/(?<!\S)#{hundred}(?= )/, translations.t(:hundred_before_words))
          end

          private

          # Only the last word is ordinal ("divdesmit pirmais"); scale words take -ais ("miljonais"), and a one-word
          # multiplier joins a round hundred or scale ordinal ("divsimtais", "divtūkstošais").
          def ordinal_words(text, number)
            ordinal = with_last_word(without_leading_one(text)) do |word|
              lookup(ordinals[:words], word) || replace_suffix(word, ordinals[:suffixes]) ||
                "#{word.sub(/[si]\z/, '')}#{ordinals[:scale_suffix]}"
            end
            fused_multiplier(ordinal, number)
          end
        end
      end
    end
  end
end
