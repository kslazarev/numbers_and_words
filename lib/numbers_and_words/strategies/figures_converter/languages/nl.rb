# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        # Spells whole numbers from the rule sets in numbers.nl.yml; see RuleSets.
        class Nl < Base
          include RuleSets

          private

          # fractional_numeral, which the decimal decorator sets, takes the words under numbers.options.fractional_numeral.
          def option_words
            @options.options[:fractional_numeral] ? [*super, 'options.fractional_numeral'] : super
          end
        end
      end
    end
  end
end
