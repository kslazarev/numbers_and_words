# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        # Spells whole numbers from the rule sets in numbers.ru.yml; see RuleSets.
        class Ru < Base
          include RuleSets
        end
      end
    end
  end
end
