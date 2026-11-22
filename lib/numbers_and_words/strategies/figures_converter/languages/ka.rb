# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        # Spells whole numbers from the rule sets in numbers.ka.yml; see RuleSets.
        class Ka < Base
          include RuleSets

          def words
            words = super
            check_scale_ordinal! if ordinal_number?
            words
          end

          private

          def cardinal_set
            'cardinal'
          end

          def check_scale_ordinal!
            number = ordinal_integer
            return if number.zero? || !(number % 1000).zero?

            number /= 1000 while (number % 1000).zero?
            return if number % 1000 == 1

            raise RangeError, 'Georgian ordinals of multiples of a thousand or more are supported only for one (მეათასე, მემილიონე)'
          end
        end
      end
    end
  end
end
