# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        # Spells whole numbers from the rule sets in numbers.cs.yml; see RuleSets.
        class Cs < Base
          include RuleSets

          ORDINAL_LIMIT = 10_000

          def words
            raise RangeError, 'Czech ordinals support numbers below 10,000' if @options.ordinal.result && ordinal_integer >= ORDINAL_LIMIT
            # remove_zero: true leaves no words for zero, also as an ordinal.
            return '' if ordinal_integer.zero? && @options.remove_zero.result

            super
          end

          private

          # A counting number's ordinal is feminine ("dvacátá první").
          def gender_words
            @options.gender.result == :counting ? 'genders.female' : super
          end
        end
      end
    end
  end
end
