# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Decorators
        module Nl
          class Integral < Base
            def run
              return '' if @options[:remove_zero] && @strategy.figures.all?(&:zero?)

              super
            end
          end
        end
      end
    end
  end
end
