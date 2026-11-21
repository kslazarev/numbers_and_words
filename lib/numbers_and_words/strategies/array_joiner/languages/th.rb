# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module ArrayJoiner
      module Languages
        # Thai joins the integral and fractional parts with จุด and no spaces.
        class Th < Base
          # Words are written without spaces, and the separator stays when remove_zero omits the integral part.
          def elements_logic
            @elements.join(union_element)
          end

          def union_element
            micro_separator
          end
        end
      end
    end
  end
end
