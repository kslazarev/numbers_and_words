# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        class Fr < Base
          def capacity_iteration
            words = []
            capacity_words = words_in_capacity(@current_capacity)
            words.push(megs) unless capacity_words.empty?
            words += capacity_words unless thousand? && one?
            words
          end

          # "cents" and "quatre-vingts" take a plural -s when they end the number or
          # precede a scale noun (millions, milliards), but not before "mille".
          def hundreds
            super({ pluralize: simple_number_to_words.empty? && !thousand? })
          end

          def tens
            super({ alone: thousand? ? false : nil })
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
        end
      end
    end
  end
end
