# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        class Se < Base
          def ones
            super(common: @current_capacity.to_i > FiguresArray::THOUSAND_CAPACITY)
          end

          def tens_with_ones
            super(common: @current_capacity.to_i > FiguresArray::THOUSAND_CAPACITY)
          end

          def hundreds_number_to_words
            [super.reverse.join]
          end

          def megs
            super(number: figures.number_in_capacity(@current_capacity))
          end

          def capacity_iteration
            number = figures.number_in_capacity(@current_capacity)
            return [] if number.zero?

            words = words_in_capacity(@current_capacity).reverse.join
            return ["#{words} #{megs}"] unless @current_capacity == FiguresArray::THOUSAND_CAPACITY

            words = words.chop if number == 1
            [[words, megs].join(separate_thousands?(number) ? ' ' : '')]
          end

          def strings_logic
            return super unless figures.capacity_count

            lower = words_in_capacity.reverse.join
            join_lower_capacity(complex_number_to_words, lower)
          end

          private

          def join_lower_capacity(higher, lower)
            thousands = figures.number_in_capacity(FiguresArray::THOUSAND_CAPACITY)
            if thousands.positive?
              higher[0] = [higher[0], lower].reject(&:empty?).join(separate_thousands?(thousands) ? ' ' : '')
            elsif !lower.empty?
              higher.unshift(lower)
            end
            higher
          end

          def separate_thousands?(number)
            number >= 21 && number % 10 != 0
          end
        end
      end
    end
  end
end
