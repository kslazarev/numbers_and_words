module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        class Ka < Base
          include Families::Latin

          private

          def capacity_iteration
            words = []
            capacity_words = words_in_capacity(@current_capacity)
            words.push(megs) unless capacity_words.empty?
            words += capacity_words unless is_a_thousand? and is_a_one?
            words
          end

          def is_a_one?
            [translations.ones(1)] == words_in_capacity(@current_capacity)
          end

          def is_a_thousand?
            FiguresArray::THOUSAND_CAPACITY == @current_capacity
          end

          def hundreds
            super({only_hundreds: figures[0, 2] == [0, 0]})
          end

          def megs
            if @figures.hundreds || @figures.tens || @figures.ones
              prefix = :partials
            else
              prefix = nil
            end

            super(prefix: prefix)
          end
        end
      end
    end
  end
end
