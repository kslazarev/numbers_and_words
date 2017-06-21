module NumbersAndWords
  module I18n
    module Plurals
      module PtBr
        RULE = lambda { |n| one_conditions(n) ? :one : :other }

        extend self

        def one_conditions n
          n == 1
        end
      end
    end
  end
end
