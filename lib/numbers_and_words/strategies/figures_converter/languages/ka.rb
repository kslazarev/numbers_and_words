# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        class Ka < Base
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
            prefix = (:partials if @figures.hundreds || @figures.tens || @figures.ones)

            super(prefix: prefix)
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
