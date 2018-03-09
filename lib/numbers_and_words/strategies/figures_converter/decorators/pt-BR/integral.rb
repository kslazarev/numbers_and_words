# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Decorators
        module PtBr
          class Integral < Base
            def run
              "#{super}#{integral_significance}"
            end

            private

            def integral_significance
              " #{@strategy.translations.integral quantity}" if @options[:remove_zero].nil?
            end

            def quantity
              figures.reverse.join.to_i
            end

            def figures
              @strategy.language.figures
            end
          end
        end
      end
    end
  end
end
