# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        # Spells whole numbers from the rule sets in numbers.el.yml; see RuleSets.
        class El < Base
          include RuleSets

          private

          # The fractional part of a decimal is neuter.
          def cardinal_set
            @options.options[:fractional] ? 'cardinal-neuter' : super
          end
        end
      end
    end
  end
end
