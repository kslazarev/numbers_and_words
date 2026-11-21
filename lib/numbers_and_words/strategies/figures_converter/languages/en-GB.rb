# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        class EnGb < En
          # "one thousand and one": a final part below one hundred after a larger unit is joined with "and",
          # like the rest of a hundred; hundreds_with_union: false leaves out both.
          def number_without_capacity_to_words
            words = words_in_capacity(0)
            lowest = @figures.number_in_capacity(0)
            union = lowest.positive? && lowest < 100 && @options.options.fetch(:hundreds_with_union, true)
            union ? words + [@translations.union] : words
          end
        end
      end
    end
  end
end
