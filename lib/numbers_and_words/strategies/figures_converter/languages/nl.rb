# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        class Nl < Base
          def hundreds_number_to_words
            [super.reverse.join]
          end

          def capacity_iteration
            if FiguresArray::THOUSAND_CAPACITY == @current_capacity
              if figures.figures_array_in_capacity(@current_capacity) == [1]
                megs
              else
                capacity_words = words_in_capacity(@current_capacity)
                capacity_words.empty? ? [] : [capacity_words, megs].join
              end
            else
              super
            end
          end

          def strings_logic
            if @current_capacity != 1 && figures == [1]
              return [@translations.t(:loose_one)]
            end
            super
          end
        end
      end
    end
  end
end
