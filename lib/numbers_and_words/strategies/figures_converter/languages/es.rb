module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        class Es < Base
          include Families::Latin
          #include NumbersAndWords::Translations::Es

          def capacity_iteration capacity
            words = []
            capacity_words = words_in_capacity(capacity)
            unless capacity_words.empty?
              words.push translations.megs(capacity, figures.number_in_capacity(capacity))
            end
            words + capacity_words
          end
        end
      end
    end
  end
end
