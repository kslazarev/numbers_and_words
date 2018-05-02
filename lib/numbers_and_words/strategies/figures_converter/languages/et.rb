# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        class Et < Base
          def megs
            super({ number: @figures.number_in_capacity(@current_capacity) })
          end
        end
      end
    end
  end
end
