# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        # Spells whole numbers from the rule sets in numbers.cs.yml; see RuleSets.
        class Cs < Base
          include RuleSets

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
