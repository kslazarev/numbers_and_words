# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        class Pl < Cs
          def words
            raise RangeError, 'Polish numbers must have magnitude below 10**48' if figures.drop(48).any?(&:positive?)

            @options.ordinal.result
            @options.gender.result
            super
          end

          def gender
            return :male unless @current_capacity.to_i.zero?
            return :male if !@options.options[:ordinal] && figures.ones == 1 && @strategy.figures.drop(1).any?(&:positive?)

            options.gender.result
          end

          def hundreds
            prefix = figures.round_hundred? ? maybe_ordinal : nil
            translate(:hundreds, figures.hundreds, { gender:, prefix: })
          end

          def capacity_iteration
            number = figures.number_in_capacity(@current_capacity)
            return [] if number.zero?
            return [megs] if number == 1

            super
          end
        end
      end
    end
  end
end
