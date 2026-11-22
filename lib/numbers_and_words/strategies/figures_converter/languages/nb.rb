# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        # Spells whole numbers from the rule sets in numbers.nb.yml; see RuleSets.
        class Nb < Base
          include RuleSets

          private

          def cardinal_set
            'cardinal'
          end

          def option_words
            [gender_words]
          end
        end
      end
    end
  end
end
