# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Options
        module Pl
          class Ordinal < Base::Ordinal
            def result
              return unless @options[:ordinal]

              raise RangeError, 'Polish ordinals support magnitudes from 0 to 999' if @strategy.figures.drop(3).any?(&:positive?)

              super
            end
          end
        end
      end
    end
  end
end
