# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        # Spells whole numbers from the rule sets in numbers.sk.yml; see RuleSets.
        class Sk < Base
          include RuleSets

          private

          def keeps_ordinal_zero?
            true
          end
        end
      end
    end
  end
end
