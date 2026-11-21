# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module ArrayJoiner
      module Languages
        # Norwegian decimals are read digit by digit, so the separator stays when remove_zero omits the integral part.
        class Nb < Base
          def elements_logic
            @elements.first.empty? ? "#{micro_separator} #{@elements.last}" : super
          end
        end
      end
    end
  end
end
