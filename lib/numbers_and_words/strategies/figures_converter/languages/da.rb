# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        class Da < Base
          prepend Ordinals

          def print_words
            complex_part.count > 1 ? print_megs_words : @strings.flatten.reverse.join(' ')
          end

          def ones
            super({ gender: })
          end

          def hundreds
            super({ is_hundred: hundred?, is_one_hundred: one_hundred? })
          end

          def megs
            super({ number: @figures.number_in_capacity(@current_capacity) })
          end

          # "et tusinde og et": a final group below one hundred after a larger unit is joined with "og".
          def number_without_capacity_to_words
            words = words_in_capacity(0)
            lowest = @figures.number_in_capacity(0)
            lowest.positive? && lowest < 100 ? words + [@translations.union] : words
          end

          # "et hundrede og et": the remainder after hundreds is joined with "og".
          def hundreds_number_to_words
            remainder = simple_number_to_words
            remainder.empty? ? [hundreds] : remainder + [@translations.union, hundreds]
          end

          private

          def simple_part
            @strings.grep_v(Array)
          end

          def complex_part
            @strings - simple_part
          end

          def hundred?
            figures[0].zero? && figures[1].zero? && simple_number_to_words.empty?
          end

          def one_hundred?
            hundred? && figures[2] == 1
          end

          def gender
            @current_capacity ||= 0
            if @current_capacity.zero?
              @options.gender.result
            elsif @current_capacity == 1
              :neuter
            else
              :common
            end
          end

          # Only the last word is ordinal, and in a compound such as "enogtyve" only its last part ("enogtyvende").
          def ordinal_words(text, _number)
            with_last_word(without_leading_one(text)) do |word|
              *head, last = word.split(ordinals[:compound], -1)
              ordinal = lookup(ordinals[:words], last) || "#{last.delete_suffix(ordinals[:plural])}#{ordinals[:scale_suffix]}"
              [*head, ordinal].join(ordinals[:compound])
            end
          end
        end
      end
    end
  end
end
