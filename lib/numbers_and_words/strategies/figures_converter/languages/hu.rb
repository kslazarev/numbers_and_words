# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        class Hu < Base
          def print_words
            inner_reverse_words.reverse.join(greater_than_2000? && '-' || '')
          end

          def inner_reverse_words
            @strings.collect { |iteration| iteration.reverse.join }
          end

          def greater_than_2000?
            @figures.length > 4 || (@figures.length == 4 && @figures.last >= 2)
          end

          def strings_logic
            if @figures.capacity_count
              number_without_capacity_to_words + complex_number_to_words
            elsif @figures.hundreds
              [hundreds_number_to_words]
            elsif @figures.tens || @figures.ones
              [simple_number_to_words]
            else
              []
            end
          end

          def complex_number_to_words
            count = @figures.capacity_count
            (1..count).map do |capacity|
              @current_capacity = capacity
              capacity_iteration.flatten
            end.reject(&:empty?)
          end

          def simple_number_to_words
            if @figures.teens || @figures.tens
              [complex_tens]
            elsif @figures.ones
              [ones]
            else
              []
            end
          end

          %i[zero ones teens tens tens_with_ones hundreds megs].each do |method_name|
            define_method(method_name) do
              super({ prefix: maybe_ordinal(method_name) })
            end
          end

          def maybe_ordinal(type)
            @options.ordinal.result type
          end
        end
      end
    end
  end
end
