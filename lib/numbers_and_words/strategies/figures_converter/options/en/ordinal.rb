# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Options
        module En
          class Ordinal < Base::Ordinal
            ZERO_TYPE = :zero
            HUNDRED_TYPE = :hundreds
            MEGS_TYPE = :megs

            def result(type)
              @type = type
              MEGS_TYPE == type ? check_megs_numbers : check_simple_numbers
            end

            private

            def check_simple_numbers
              :ordinal if simple_numbers_condition && active?
            end

            def check_megs_numbers
              :ordinal if megs_numbers_condition && active?
            end

            def simple_numbers_condition
              current_capacity.nil? &&
                (HUNDRED_TYPE != @type ||
                 HUNDRED_TYPE == @type && simple_number_to_words.empty?)
            end

            def megs_numbers_condition
              current_capacity == language_figures.ordinal_capacity
            end

            def simple_number_to_words
              @strategy.language.simple_number_to_words
            end

            def current_capacity
              @strategy.language.current_capacity
            end

            def language_figures
              @strategy.language.parent_figures
            end
          end
        end
      end
    end
  end
end
