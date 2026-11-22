# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        # Spells whole numbers from the rule sets in numbers.fr.yml; see RuleSets. spelling: :traditional separates
        # the words of a group with spaces instead of hyphens (numbers.options.traditional).
        class Fr < Base
          include RuleSets

          private

          def cardinal_set
            'cardinal'
          end

          def option_words
            @options.spelling.result == :traditional ? ['options.traditional'] : []
          end
        end
      end
    end
  end
end
