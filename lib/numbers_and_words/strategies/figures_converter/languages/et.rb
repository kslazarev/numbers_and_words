# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        class Et < Base
          prepend Ordinals

          def megs
            super({ number: @figures.number_in_capacity(@current_capacity) })
          end

          private

          # The last word is ordinal and every word before it is genitive ("kahekümne esimene", "kahe miljoni
          # kahekümne esimene").
          def ordinal_words(text, _number)
            *head, last = without_leading_one(text).split
            [*head.map { |word| ordinal_forms(word).first }, ordinal_forms(last).last].join(' ')
          end

          # The genitive and ordinal forms of a cardinal word.
          def ordinal_forms(word)
            unit_forms(word) || lookup(ordinals[:words], word) || compound_forms(word) || scale_forms(word)
          end

          def unit_forms(word)
            index = @translations.t(:ones).index(word)
            [ordinals[:genitive][index], ordinals[:ordinal][index]] if index
          end

          # "kakskümmend" (twenty) is "kaks" (two) and "kümmend": its forms are "kahe" with those of "kümmend".
          def compound_forms(word)
            suffix, endings = ordinals[:compounds].find { |key, _| word.end_with?(key.to_s) }
            return unless suffix

            stem = unit_forms(word.delete_suffix(suffix.to_s)).first
            endings.map { |ending| "#{stem}#{ending}" }
          end

          def scale_forms(word)
            stem = word.delete_suffix(ordinals[:scale_plural])
            ordinals[:scale].map { |ending| "#{stem}#{ending}" }
          end
        end
      end
    end
  end
end
