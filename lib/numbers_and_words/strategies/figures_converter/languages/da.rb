# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        class Da < Base

          def print_words
            complex_part.count > 1 ? print_megs_words : @strings.flatten.reverse.join(' ')
          end

          def ones
            super({ gender: gender })
          end

          def hundreds
            super({ is_hundred: hundred?, is_one_hundred: one_hundred? })
          end

          def megs
            super({ number: @figures.number_in_capacity(@current_capacity) })
          end

          private

          def print_other
            [print_thousands, simple_part.reverse.join].join
          end

          def print_thousands
            complex_part.first.reverse.join
          end

          def simple_part
            @strings.reject { |f| f.is_a?(Array) }
          end

          def complex_part
            @strings - simple_part
          end

          def hundred?
            figures[0].zero? && figures[1].zero? && simple_number_to_words.empty?
          end

          def one_hundred?
            hundred? && figures[2] == 1
          end

          def gender
            @options.gender.result
          end
        end
      end
    end
  end
end
