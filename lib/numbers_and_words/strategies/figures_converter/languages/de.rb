module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        class De < Base
          include Families::Latin

          def print_words
            1 < complex_part.count ? print_megs_words : @strings.flatten.reverse.join('')
          end

          def print_megs_words
            [print_megs, print_other].select(&:present?).join ' '
          end

          def complex_number_to_words
            (1..@figures.capacity_count).map { |capacity|
              @current_capacity = capacity
              capacity_iteration
            }
          end

          def ones
            super(:postfix => postfix)
          end

          def postfix
            case (@current_capacity ||= 0)
            when 1 then :combine
            when 0 then :default
            else :gender
            end
          end

          def megs
            super({:number => @figures.number_in_capacity(@current_capacity)})
          end

          private

          def print_megs
            complex_part[1..-1].map { |el|
              [el[1..-1].to_a.reverse.join(''), el.first].join(' ')
            }.select(&:present?).reverse.join(' ')
          end

          def print_other
            [print_thousands, simple_part.reverse.join('')].join('')
          end

          def print_thousands
            complex_part.first.reverse.join('')
          end

          def simple_part
            @strings.select { |f| !f.is_a?(Array) }
          end

          def complex_part
            @strings - simple_part
          end
        end
      end
    end
  end
end