# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Decorators
        module Hu
          class Fractional < Base
            def run
              "#{before_noun(super)} #{fraction_significance(nil)}"
            end
          end
        end
      end
    end
  end
end
