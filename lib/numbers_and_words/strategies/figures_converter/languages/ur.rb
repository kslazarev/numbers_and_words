# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        # Spells whole numbers from the rule sets in numbers.ur.yml; see RuleSets.
        class Ur < Base
          include RuleSets

          private

          def cardinal_set
            'cardinal'
          end

          def keeps_ordinal_zero?
            true
          end
        end
      end
    end
  end
end
