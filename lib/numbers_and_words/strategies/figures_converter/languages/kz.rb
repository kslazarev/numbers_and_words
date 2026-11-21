# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        class Kz < Base
          # A thousands group of one is just the scale word ("мың").
          def capacity_iteration
            return [megs] if @current_capacity == FiguresArray::THOUSAND_CAPACITY && @figures.number_in_capacity(@current_capacity) == 1

            super
          end
        end
      end
    end
  end
end
