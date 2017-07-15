module NumbersAndWords
  module I18n
    module Plurals
      module Lt
        module_function

        RULE = lambda do |n|
          if one_conditions(n)
            :one
          elsif ones_conditions(n)
            :ones
          else
            :other
          end
        end

        def one_conditions(n)
          n % 10 == 1 && n % 100 != 11
        end

        def ones_conditions(n)
          [2, 3, 4, 5, 6, 7, 8, 9].include?(n % 10) && ![12, 13, 14, 15, 16, 17, 18, 19].include?(n % 100)
        end
      end
    end
  end
end
