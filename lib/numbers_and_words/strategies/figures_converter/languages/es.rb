# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        # Spells whole numbers from the rule sets in numbers.es.yml; see RuleSets. The last group takes the feminine
        # words under numbers.genders.female, or the apocopated ones under numbers.options.apocopated.
        class Es < Base
          include RuleSets

          private

          def option_words
            female = @options.gender.result == :female
            [('genders.female' if female), ('options.apocopated' if @options.apocopated.result && !female)]
          end
        end
      end
    end
  end
end
