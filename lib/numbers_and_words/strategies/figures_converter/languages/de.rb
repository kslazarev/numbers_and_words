# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        # Spells whole numbers from the rule sets in numbers.de.yml; see RuleSets.
        class De < Base
          include RuleSets

          private

          def cardinal_set
            'cardinal'
          end
        end
      end
    end
  end
end
