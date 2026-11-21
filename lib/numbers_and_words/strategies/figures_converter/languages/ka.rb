# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        class Ka < Base
          prepend Ordinals

          def capacity_iteration
            words = []
            capacity_words = words_in_capacity(@current_capacity)
            words.push(megs) unless capacity_words.empty?
            words += capacity_words unless thousand? && one?
            words
          end

          def hundreds
            super({ only_hundreds: figures[0, 2] == [0, 0] })
          end

          def megs
            prefix = (:partials if @figures.number_under_capacity(@current_capacity).positive?)

            super(prefix:)
          end

          private

          def one?
            words_in_capacity(@current_capacity) == [translations.ones(1)]
          end

          def thousand?
            @current_capacity == FiguresArray::THOUSAND_CAPACITY
          end

          # 1 is პირველი; otherwise the last word, or the last part of a compound with და, takes მე- and its
          # final vowel becomes -ე ("მეორე", "ოცდამეერთე").
          def ordinal_words(text, number)
            return ordinals[:first] if number == 1

            check_scale_ordinal!(number)

            with_last_word(without_leading_one(text)) do |word|
              head, separator, tail = word.rpartition(ordinals[:compound])
              "#{head}#{separator}#{ordinals[:prefix]}#{tail[0..-2]}#{ordinals[:suffix]}"
            end
          end

          # A multiple of a thousand or more with a multiplier other than one ("ორი მეათასე") would read as a
          # fraction, and its ordinal form needs a native speaker's review, so it raises instead.
          def check_scale_ordinal!(number)
            return if number.zero? || !(number % 1000).zero?

            number /= 1000 while (number % 1000).zero?
            return if number % 1000 == 1

            raise RangeError, 'Georgian ordinals of multiples of a thousand or more are supported only for one (მეათასე, მემილიონე)'
          end
        end
      end
    end
  end
end
