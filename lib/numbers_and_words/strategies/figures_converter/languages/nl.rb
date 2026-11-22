# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        # Spells whole numbers from the rule sets in numbers.nl.yml; see RuleSets.
        class Nl < Base
          include RuleSets

          private

          def cardinal_set
            hundreds? ? 'number-hundreds' : 'number'
          end

          def ordinal_set
            hundreds? ? 'ordinal-hundreds' : 'ordinal'
          end

          def hundreds?
            @options.options[:tens_of_hundreds] || @options.options[:pronounced]
          end

          def option_words
            %i[pronounced fractional_numeral].filter_map { |option| "options.#{option}" if @options.options[option] }
          end
        end
      end
    end
  end
end
