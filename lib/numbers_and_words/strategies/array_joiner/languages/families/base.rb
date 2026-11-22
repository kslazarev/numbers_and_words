# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module ArrayJoiner
      module Languages
        module Families
          module Base
            # Without an integral part, as remove_zero leaves it, the fractional part alone, or after the decimal
            # word ("point seven") in a language that declares remove_zero: {keeps_micro_separator: true}.
            def elements_logic
              return @elements.join(union_element) unless @elements.first.empty?

              keeps_micro_separator? ? "#{micro_separator} #{@elements.last}" : @elements.last
            end

            def union_element
              micro_separator.empty? ? ' ' : " #{micro_separator} "
            end

            # The decimal word, or the fraction word for fraction: true.
            def micro_separator
              options[:micro_separator] || (options[:fraction] ? @translations.t(:fraction_separator) : @translations.micro_separator) || ''
            end

            def keeps_micro_separator?
              declared = OptionsValidation.declared_options(I18n.local_language)[:remove_zero]
              !options[:fraction] && declared.is_a?(::Hash) && declared[:keeps_micro_separator] == true
            end
          end
        end
      end
    end
  end
end
