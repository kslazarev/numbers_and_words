# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        # Spells whole numbers from the rule sets in numbers.ro.yml; see RuleSets.
        class Ro < Base
          include RuleSets

          private

          # The fractional part of a decimal is masculine.
          def cardinal_set
            @options.options[:fractional] ? 'cardinal-male' : super
          end
        end
      end
    end
  end
end
