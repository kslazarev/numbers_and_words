module NumbersAndWords
  module Translations
    module Families
      module Cyrillic
        include NumbersAndWords::Translations::Families::Base

        def ones number, gender = :male
          t(:ones)[gender][number]
        end

        def tens_with_ones numbers, gender, separator = ' '
          [tens(numbers[1]), ones(numbers[0], gender)].join separator
        end

        def hundreds number
          t(:hundreds)[number]
        end

        def zero
          t(:ones).values.first[0]
        end


        def integral_word number
          t(:integral_word, :count => number)
        end
      end
    end
  end
end
