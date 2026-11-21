# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module ArrayJoiner
      module Languages
        # Korean joins the integral and fractional parts with 점 between spaces: 삼 점 일사.
        class Ko < Base
          # Decimals are read digit by digit, so the separator stays when remove_zero omits the integral part.
          def elements_logic
            @elements.first.empty? ? "#{micro_separator} #{@elements.last}" : super
          end
        end
      end
    end
  end
end
