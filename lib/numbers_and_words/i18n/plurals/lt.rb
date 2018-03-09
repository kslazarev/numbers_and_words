# frozen_string_literal: true

module NumbersAndWords
  module I18n
    module Plurals
      module Lt
        module_function

        RULE = lambda do |number|
          if one_conditions(number)
            :one
          elsif ones_conditions(number)
            :ones
          else
            :other
          end
        end

        def one_conditions(number)
          number % 10 == 1 && number % 100 != 11
        end

        def ones_conditions(number)
          [2, 3, 4, 5, 6, 7, 8, 9].include?(number % 10) &&
            ![12, 13, 14, 15, 16, 17, 18, 19].include?(number % 100)
        end
      end
    end
  end
end
