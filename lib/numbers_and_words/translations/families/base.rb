module NumbersAndWords
  module Translations
    module Families
      module Base

        #private

        def teens number
          t(:teens)[number]
        end

        def tens number
          t(:tens)[number]
        end

        def tens_with_ones numbers, separator = ' '
          [tens(numbers[1]), ones(numbers[0])].join separator
        end

        def megs capacity, number = nil
          number ? t(mega(capacity), :count => number) : t(:mega)[capacity]
        end

        def mega capacity
          t(:mega)[capacity]
        end

        def fraction_separator options = {}
          t(:fraction_separator)
        end
      end
    end
  end
end
