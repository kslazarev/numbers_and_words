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
            words += capacity_words unless thousand? && one?
            words
          end

          def one?
            words_in_capacity(@current_capacity) == [translations.ones(1)]
          end

          def thousand?
            FiguresArray::THOUSAND_CAPACITY == @current_capacity
          end

          def hundreds
            super({ only_hundreds: figures[0, 2] == [0, 0] })
          end

          def megs
            prefix = if @figures.hundreds || @figures.tens || @figures.ones
                       :partials
                     end

            super(prefix: prefix)
          end
        end
      end
    end
  end
end
