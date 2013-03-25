module NumbersAndWords
  module Translations
    module Families
      module Cyrillic
        include NumbersAndWords::Translations::Families::Base

        def ones number, options = {}
          t(:ones)[options[:gender]][number]
        end

        def tens_with_ones numbers, options = {}
          [tens(numbers[1]), ones(numbers[0], options)].join ' '
        end

        def hundreds number, options = {}
          t(:hundreds)[number]
        end

        def zero options = {}
          t(:ones).values.first[0]
        end

        def integral number, options = {}
          t(:integral, :count => number)
        end
      end
    end
  end
end
