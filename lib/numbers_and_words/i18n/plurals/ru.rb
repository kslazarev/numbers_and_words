module NumbersAndWords
  module I18n
    module Plurals
      module Ru
        RULE = lambda do |n|
           one_conditions(n) ?
            :one : few_conditions(n) ?
              :few : many_conditions(n) ?
                :many : :other
        end

        extend self

        def one_conditions n
          n % 10 == 1 && n % 100 != 11
        end

        def few_conditions n
          [2, 3, 4].include?(n % 10) && ![12, 13, 14].include?(n % 100)
        end

        def many_conditions n
          n % 10 == 0 || [5, 6, 7, 8, 9].include?(n % 10) || [11, 12, 13, 14].include?(n % 100)
        end
      end
    end
  end
end
