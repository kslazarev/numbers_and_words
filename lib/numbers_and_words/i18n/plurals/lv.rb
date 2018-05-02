# frozen_string_literal: true

module NumbersAndWords
  module I18n
    module Plurals
      module Lv
        module_function

        RULE = ->(number) { one_conditions(number) ? :one : :other }

        def one_conditions(number)
          number % 10 == 1 && number % 100 != 11
        end
      end
    end
  end
end
