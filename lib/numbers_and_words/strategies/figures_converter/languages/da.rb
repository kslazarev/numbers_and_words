# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        # Spells whole numbers from the rule sets in numbers.da.yml; see RuleSets.
        class Da < Base
          include RuleSets

          private

          def cardinal_set
            @options.gender.result == :neuter ? 'neuter' : 'cardinal'
          end
        end
      end
    end
  end
end
