# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        # Spells whole numbers from the rule sets in numbers.pt.yml; see RuleSets.
        class Pt < Base
          include RuleSets

          private

          # Inteiro and décimo are masculine whatever is counted ("dois inteiros e dois décimos").
          def cardinal_set
            @options.options[:fraction] && decimal_part? ? 'cardinal-male' : super
          end
        end
      end
    end
  end
end
