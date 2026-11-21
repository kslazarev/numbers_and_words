# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module ArrayJoiner
      module Languages
        # Hebrew joins the integral and fractional parts with נקודה, which stays when remove_zero omits the integral part.
        class He < Base
          def elements_logic
            @elements.first.empty? ? [micro_separator, @elements.last].join(' ') : super
          end
        end
      end
    end
  end
end
