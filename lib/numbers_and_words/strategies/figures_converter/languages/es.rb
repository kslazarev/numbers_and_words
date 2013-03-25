module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        class Es < Base
          include Families::Latin

          def capacity_iteration
            words = []
            capacity_words = words_in_capacity(@current_capacity)
            words.push megs(capacity_words) unless capacity_words.empty?

            if 0 < @current_capacity
              # eg 1000000 should be "un millon" not "uno millon"
              #    501000 should be "quinientos un mil" not "quinientos uno mil"
              # so we replace "uno" with "un" throughout

              capacity_words = capacity_words.map{|word|
                word.gsub( @translations.ones(1), @translations.one )
              }
            end

            words + capacity_words
          end

          def hundreds
            super({:is_hundred => (figures[1,2] == [0,1] && simple_number_to_words.empty?)})
          end

          def megs capacity_words
            super({:is_one => capacity_words == [@translations.ones(1)]})
          end
        end
      end
    end
  end
end
