# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        # Spells whole numbers from the rule sets in numbers.pl.yml; see RuleSets. Ordinals stop below 1,000 (see
        # Options::Pl::Ordinal).
        class Pl < Base
          include RuleSets

          def words
            raise Translations::Families::Base.range_error(48) if figures.drop(48).any?(&:positive?)

            super
          end
        end
      end
    end
  end
end
