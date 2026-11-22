# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        # Spells whole numbers from the rule sets in numbers.he.yml; see RuleSets. An ordinal above ten is the
        # cardinal with the definite article on its first word, or on its second when that is a scale noun
        # ("העשרים ואחת", "שלוש המאות").
        class He < Base
          include RuleSets

          def words
            return super unless ordinal_number?
            raise RangeError, 'Hebrew ordinals start at 1' if ordinal_integer.zero?
            return super if ordinal_integer <= 10

            first, second, *rest = cardinal(ordinal_integer).split
            definite = @translations.t(:definite)
            return [first, "#{definite}#{second}", *rest].join(' ') if scale_noun?(second)

            "#{definite}#{[first, second, *rest].compact.join(' ')}"
          end

          private

          def scale_noun?(word)
            nouns = [@translations.t(:hundreds).last, @translations.t(:thousands).last].map { |words| words.split.last }
            [*nouns, *@translations.t(:mega).drop(2).map { |key| @translations.t(key) }].include?(word)
          end
        end
      end
    end
  end
end
