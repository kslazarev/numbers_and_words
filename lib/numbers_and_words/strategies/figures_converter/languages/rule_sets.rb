# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        # Spells whole numbers from the rule sets under numbers.rules in the locale file (see NumbersAndWords::Rules):
        # gender: and animate: pick a rule set, case: the words under numbers.cases, and an ordinal is spelled in the
        # masculine nominative and then declined through numbers.ordinals.endings, or spelled with the words under
        # numbers.genders.<gender>. A case without words of its own, such as the Ukrainian vocative, uses the
        # nominative ones. A language can pick other rule sets with cardinal_set and ordinal_set, and other words with
        # option_words, such as the words under numbers.options.<option> for an option that is on.
        module RuleSets
          include Ordinals

          def words
            ordinal = ordinal_number?
            return '' if removed_zero?(ordinal)
            return declined(rules(gender_words, *option_words).spell(ordinal_integer, ordinal_set)) if ordinal

            cardinal(ordinal_integer)
          end

          private

          # remove_zero: true leaves no words for zero, also as an ordinal unless the language keeps it.
          def removed_zero?(ordinal)
            ordinal_integer.zero? && @options.remove_zero&.result && !(ordinal && keeps_ordinal_zero?)
          end

          def cardinal(number)
            return rules(*option_words).spell(number, cardinal_set) if grammatical_case == :nominative
            raise UnsupportedOptionError, "case: #{grammatical_case.inspect} is not supported for decimals" if decimal_part?

            rules(case_words, *option_words).spell(number, cardinal_set)
          end

          def ordinal_set
            'ordinal'
          end

          def option_words
            []
          end

          def keeps_ordinal_zero?
            false
          end

          # An animate accusative takes the genitive of a final "one", and of "two", "three" and "four" alone.
          def cardinal_set
            animate = grammatical_case == :accusative && @options.animate&.result
            "cardinal-#{@options.gender.result}#{'-animate' if animate}"
          end

          def case_words
            "cases.#{grammatical_case}" if @translations.t(:cases).key?(grammatical_case)
          end

          def gender_words
            gender = @options.gender&.result
            "genders.#{gender}" if @translations.t(:genders, default: {}).key?(gender)
          end

          def rules(*words)
            Rules.new(@translations, limit, words: words.compact)
          end

          # Numbers stop below the first scale word past the last in numbers.mega, if the locale lists them.
          def limit
            mega = @translations.t(:mega, default: nil)
            mega && (mega.size * 3)
          end

          def grammatical_case
            @options.options.fetch(:case, :nominative).to_sym
          end

          def decimal_part?
            !(@options.options[:integral].nil? && @options.options[:fractional].nil?)
          end
        end
      end
    end
  end
end
