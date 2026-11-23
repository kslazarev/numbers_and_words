# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        # Spells whole numbers from the rule sets in numbers.ar.yml; see RuleSets. An ordinal from 100 is the definite
        # cardinal, so ordinals look up the words under numbers.definite first.
        class Ar < Base
          include RuleSets

          private

          def option_words
            ordinal_number? ? ['definite'] : []
          end
        end
      end
    end
  end
end
