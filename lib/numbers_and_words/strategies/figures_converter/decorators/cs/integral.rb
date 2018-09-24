# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Decorators
        module Cs
          class Integral < Base
            def run
              @options[:gender] = :female
              [super, integral_significance].compact.join(' ')
            end

            private

            def integral_significance
              figs = figures.reverse.join.to_i
              return nil if @options[:remove_zero] && figs.zero?

              @strategy.translations.integral figs
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
