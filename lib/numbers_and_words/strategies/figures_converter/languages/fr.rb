module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        class Fr < Base
          include Families::Latin

          private

          def capacity_iteration capacity
            words = []
            capacity_words = words_in_capacity(capacity)
            unless capacity_words.empty?
             words.push translations.megs(capacity,figures.number_in_capacity(capacity))
            end
            words += capacity_words unless is_a_thousand?(capacity) and is_a_one?(capacity_words)
            words
          end

          def is_a_one? capacity_words
            translations.ones(1) == capacity_words
          end

          def is_a_thousand? capacity
            FiguresArray::THOUSAND_CAPACITY == capacity
          end

          def hundreds_number_to_words
            simple_number_to_words + [
              translations.hundreds(figures.hundreds, simple_number_to_words.empty?)
            ]
          end
        end
      end
    end
  end
end