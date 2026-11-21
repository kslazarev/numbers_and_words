# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module ArrayJoiner
      module Languages
        class Vi < Base
          # Decimals are read digit by digit, so the separator stays when remove_zero omits the integral part.
          def elements_logic
            @elements.first.empty? ? "#{micro_separator} #{@elements.last}" : super
          end
        end
      end
    end
  end
end
