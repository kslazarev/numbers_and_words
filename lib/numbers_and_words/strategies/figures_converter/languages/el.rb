# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        # Spells whole numbers from the rule sets in numbers.el.yml; see RuleSets.
        class El < Base
          include RuleSets

          ORDINAL_LIMIT = 10_000

          # Numbers too large for cardinals raise the cardinal RangeError first.
          def words
            limited = ordinal_integer.between?(ORDINAL_LIMIT, (10**(@translations.t(:mega).size * 3)) - 1)
            raise RangeError, 'Greek ordinals support numbers below 10,000' if ordinal_number? && limited

            super
          end

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
