module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        class Es < Base
          include Families::Latin

          def capacity_iteration
            words = []
            capacity_words = words_in_capacity(@current_capacity)
            words.push megs unless capacity_words.empty?
            words + capacity_words
          end

          def megs
            super({:number => @figures.number_in_capacity(@current_capacity)})
          end
        end
      end
    end
  end
end
