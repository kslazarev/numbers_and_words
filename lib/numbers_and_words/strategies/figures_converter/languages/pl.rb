module NumbersAndWords
    module Strategies
      module FiguresConverter
        module Languages
          class Pl < Base

            def megs
              super({:number => @figures.number_in_capacity(@current_capacity)})
            end

            private

            def one?
              words_in_capacity(@current_capacity) == [translations.ones(1)]
            end

            def thousand?
              FiguresArray::THOUSAND_CAPACITY == @current_capacity
            end

          end
        end
      end
    end
  end