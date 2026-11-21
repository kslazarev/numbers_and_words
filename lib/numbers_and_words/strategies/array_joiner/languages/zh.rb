# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module ArrayJoiner
      module Languages
        # Chinese joins the integral and fractional parts with 点 and no spaces.
        class Zh < Base
          def union_element
            micro_separator
          end

          # Words are written without spaces, and the separator stays when remove_zero omits the integral part.
          def elements_logic
            @elements.join(union_element)
          end
        end
      end
    end
  end
end
