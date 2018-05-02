# frozen_string_literal: true

module NumbersAndWords
  module I18n
    module Plurals
      module Cs
        module_function

        RULE = lambda do |number|
          if one_conditions(number)
            :one
          elsif few_conditions(number)
            :few
          elsif many_conditions(number)
            :many
          else
            :other
          end
        end

        def one_conditions(number)
          number % 10 == 1 && number % 100 != 11
        end

        def few_conditions(number)
          [2, 3, 4].include?(number % 10) &&
            ![12, 13, 14].include?(number % 100)
        end

        def many_conditions(number)
          (number % 10).zero? ||
            [5, 6, 7, 8, 9].include?(number % 10) ||
            [11, 12, 13, 14].include?(number % 100)
        end
      end
    end
  end
end
