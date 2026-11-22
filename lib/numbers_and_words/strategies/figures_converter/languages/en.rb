# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        # Spells whole numbers from the rule sets in numbers.en.yml; see RuleSets. remove_hyphen: and
        # hundreds_with_union: change the words under numbers.options.
        class En < Base
          include RuleSets

          private

          def cardinal_set
            pronounced? ? 'pronounced' : 'cardinal'
          end

          def ordinal_set
            pronounced? ? 'pronounced-ordinal' : 'ordinal'
          end

          # Up to four digits, unless the hundreds digit is zero ("two thousand one").
          def pronounced?
            number = ordinal_integer
            @options.options[:pronounced] && number.between?(100, 9999) && (number < 1000 || !(number / 100 % 10).zero?)
          end
        end
      end
    end
  end
end
