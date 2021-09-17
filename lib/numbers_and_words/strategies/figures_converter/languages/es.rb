# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        class Es < Base
          def capacity_iteration
            super.compact
          end

          def zero
            super unless maybe_remove_zero
          end

          def ones
            super({ gender: gender,
                    is_one_thousand: one_thousand?,
                    is_apocopated: one_apocopated? })
          end

          def tens_with_ones
            options = { gender: gender, is_apocopated: one_apocopated? }
            return @translations.twenties_with_ones(@figures, options) if @figures.tens == 2

            super(options)
          end

          def hundreds
            super({ gender: gender,
                    is_apocopated: hundred_apocopated? })
          end

          def megs
            return @translations.megs(1, number: 1) if long_scale_thousand?

            super({ number: @figures.number_in_capacity(@current_capacity) })
          end

          private

          def one_thousand?
            @current_capacity.odd? &&
              @figures.ones == 1 &&
              @figures.tens.nil? &&
              @figures.hundreds.nil?
          end

          def long_scale_thousand?
            @current_capacity.odd? &&
              !@figures.number_in_capacity(@current_capacity - 1).zero?
          end

          def one_apocopated?
            (@current_capacity.positive? && @figures.ones == 1) ||
              @options.apocopated.result
          end

          def hundred_apocopated?
            @figures.hundreds == 1 && @figures.round_hundred?
          end

          def gender
            @current_capacity ||= 0

            return :male if @current_capacity >= 2

            @options.gender.result
          end

          def maybe_remove_zero
            @options.remove_zero.result
          end
        end
      end
    end
  end
end
