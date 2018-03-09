# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        class Lv < Base
          def tens_with_ones
            super separator: ' '
          end

          def megs
            super({ number: @figures.number_in_capacity(@current_capacity) })
          end
        end
      end
    end
  end
end
