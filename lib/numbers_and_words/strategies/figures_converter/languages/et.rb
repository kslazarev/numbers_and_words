module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        class Et < Base
          include Families::Latin

          def megs
            super({:number => @figures.number_in_capacity(@current_capacity)})
          end

        end
      end
    end
  end
end
