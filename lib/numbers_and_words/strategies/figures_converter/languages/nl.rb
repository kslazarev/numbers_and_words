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
            return super if FiguresArray::THOUSAND_CAPACITY != @current_capacity
            return [] if figures.number_in_capacity(@current_capacity) == 1

            capacity_words = words_in_capacity(@current_capacity)
            capacity_words.empty? ? [] : [capacity_words, megs].join
          end

          def simple_number_to_words
            if @figures.only_ones && @figures.ones == 1
              [@translations.t(:loose_one)]
            else
              super
            end
          end

          def number_without_capacity_to_words
            return super unless figures.number_in_capacity(1) == 1

            if figures.hundreds
              teen_hundreds = @figures[2, 2].to_figures
              [([@translations.teens(teen_hundreds), translate(:hundreds, 1)] + simple_number_to_words).join]
            else
              simple_number_to_words + [translate(:mega, 1)]
            end
          end
        end
      end
    end
  end
end
