module NumbersAndWords
  module I18n
    module Plurals
      module Es
        include Fr

        RULE = Fr::RULE

        extend self

        def one_conditions(n)
          n == 1
        end
      end
    end
  end
end
