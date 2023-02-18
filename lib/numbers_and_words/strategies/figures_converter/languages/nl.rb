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
            return super if @current_capacity != FiguresArray::THOUSAND_CAPACITY
            return [] if apply_tens_of_hundreds?
            return megs if figures.number_in_capacity(@current_capacity) == 1

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
            return super unless apply_tens_of_hundreds?

            base = save_parent_figures do
              @figures = @parent_figures[2, 2].to_figures
              simple_number_to_words
            end
            [([base, translate(:hundreds, 1)] + simple_number_to_words).join]
          end

          private

          def apply_tens_of_hundreds?
            @options.tens_of_hundreds.result &&
              (1..9).cover?(figures.number_in_capacity(FiguresArray::THOUSAND_CAPACITY)) &&
              figures.hundreds
          end
        end
      end
    end
  end
end
