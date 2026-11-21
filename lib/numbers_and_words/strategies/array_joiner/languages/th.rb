# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module ArrayJoiner
      module Languages
        # Thai joins the integral and fractional parts with จุด and no spaces.
        class Th < Base
          def union_element
            micro_separator
          end
        end
      end
    end
  end
end
