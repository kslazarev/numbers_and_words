# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        # Spells whole numbers from the rule sets in numbers.ko.yml; see RuleSets.
        class Ko < Base
          include Myriad

          def words
            check_scale!('Korean')
            super
          end

          private

          def scales
            @translations.t(:scales)
          end
        end
      end
    end
  end
end
