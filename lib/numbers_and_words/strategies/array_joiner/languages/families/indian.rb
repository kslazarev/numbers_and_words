# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module ArrayJoiner
      module Languages
        module Families
          # Hindi, Bengali and Urdu join the integral and fractional parts with their decimal word, which stays
          # when remove_zero omits the integral part ("दशमलव सात").
          module Indian
            def elements_logic
              @elements.first.empty? ? [micro_separator, @elements.last].join(' ') : super
            end
          end
        end
      end
    end
  end
end
