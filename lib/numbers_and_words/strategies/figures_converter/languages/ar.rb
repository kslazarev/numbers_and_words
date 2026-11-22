# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        # Spells whole numbers from the rule sets in numbers.ar.yml; see RuleSets.
        class Ar < Base
          include RuleSets

          ORDINALS = (1..99)

          def words
            raise RangeError, 'Arabic ordinals support 1 to 99' if @options.ordinal.result && !ORDINALS.cover?(ordinal_integer)

            super
          end

          private

          def cardinal_set
            'cardinal'
          end
        end
      end
    end
  end
end
