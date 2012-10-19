module NumbersAndWords
  module I18n
    module Plurals
      module Fr
        RULE = lambda { |n| one_conditions(n) ? :one : :many }

        extend self

        def one_conditions n
          n % 10 == 1 && n % 100 != 11
        end
      end
    end
  end
end
