# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        class Ru < Base
          prepend Cases
          prepend Ordinals

          # remove_zero: true omits a zero integral part.
          def zero(*args)
            super unless @options.remove_zero.result
          end

          include Families::Cyrillic

          private

          # Only the last word is ordinal ("двадцать первый"), and a round thousand or million joins its multiplier to the
          # scale word ("двухтысячный"). gender: :female and :neuter change the ending.
          def ordinal_words(text, _number)
            joined_scale_ordinal_words(text)
          end
        end
      end
    end
  end
end
