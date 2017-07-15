module NumbersAndWords
  module I18n
    module Plurals
      module Fr
        module_function

        RULE = ->(n) { one_conditions(n) ? :one : :other }

        def one_conditions(n)
          n % 10 == 1 && n % 100 != 11
        end
      end
    end
  end
end
