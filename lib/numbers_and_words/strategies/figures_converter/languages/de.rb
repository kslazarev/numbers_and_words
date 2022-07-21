# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        class De < Base
          def print_words
            complex_part.count > 1 ? print_megs_words : @strings.flatten.reverse.join
          end

          def print_megs_words
            [print_megs, print_other].reject(&:empty?).join(' ')
          end

          def complex_number_to_words
            (1..@figures.capacity_count).map do |capacity|
              @current_capacity = capacity
              capacity_iteration
            end
          end

          def ones
            super(postfix: postfix)
          end

          def postfix
            case (@current_capacity ||= 0)
            when 1 then :combine
            when 0 then :default
            else :gender
            end
          end

          def megs
            super({ number: @figures.number_in_capacity(@current_capacity) })
          end

          private

          def print_megs
            complex_part[1..].map do |el|
              [el[1..].to_a.reverse.join, el.first].join(' ')
            end.reject(&:empty?).reverse.join(' ')
          end

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
        end
      end
    end
  end
end
