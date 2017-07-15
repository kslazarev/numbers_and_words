module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        class Pt < Base
          include Families::Latin

          def hundreds
            super({ is_hundred: hundred?, is_one_hundred: one_hundred? })
          end

          def megs
            super({ is_one: words_in_capacity(@current_capacity) == [@translations.ones(1)] })
          end

          private

          def hundred?
            figures[0] == 0 && figures[1] == 0 && simple_number_to_words.empty?
          end

          def one_hundred?
            hundred? && figures[2] == 1
          end
        end
      end
    end
  end
end
