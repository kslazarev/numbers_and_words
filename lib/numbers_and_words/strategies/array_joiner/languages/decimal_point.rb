# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module ArrayJoiner
      module Languages
        # Joins the integral and fractional parts with the decimal point word, keeping it when remove_zero omits
        # the integral part ("point seven"), or with the fraction word for fraction: true.
        module DecimalPoint
          def elements_logic
            return super if options[:fraction]

            @elements.first.empty? ? "#{micro_separator} #{@elements.last}" : super
          end

          def micro_separator
            options[:micro_separator] || (options[:fraction] ? @translations.t(:fraction_separator) : super)
          end
        end
      end
    end
  end
end
