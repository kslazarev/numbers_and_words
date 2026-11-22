# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Decorators
        class Base
          def initialize(strategy, options)
            @strategy = strategy
            @options = options
          end

          def run
            yield
          end

          private

          # The fraction word for the length of the fractional part, such as "hundredths", in the form for number.
          def fraction_significance(number = fractional_number)
            @strategy.translations.micros fraction_capacity, number
          end

          # The scale of the fraction word: a hundredth for 0.05 with precision: 2.
          def fraction_capacity
            Array.new([fraction_length + 1, @strategy.figures.length].max, 0).to_figures.fraction_capacity
          end

          def fractional_number
            @strategy.figures.reverse.join.to_i
          end

          def fraction_length
            @options[:fractional][:length].to_i
          end
        end
      end
    end
  end
end
