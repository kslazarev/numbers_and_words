# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        # Spells whole numbers from the rule sets under numbers.rules in the locale file (see NumbersAndWords::Rules):
        # gender: and animate: pick a rule set, case: the words under numbers.cases, and an ordinal is spelled in the
        # masculine nominative and then declined through numbers.ordinals.endings, or spelled with the words under
        # numbers.genders.<gender>. A case without words of its own, such as the Ukrainian vocative, uses the
        # nominative ones.
        module RuleSets
          include Ordinals

          def words
            return declined(rules(gender_words).spell(ordinal_integer, 'ordinal')) if ordinal_number?

            number = @figures.to_a.reverse.join.to_i
            # remove_zero: true leaves no words for a zero integral part.
            number.zero? && @options.remove_zero.result ? '' : cardinal(number)
          end

          private

          def cardinal(number)
            return rules.spell(number, cardinal_set) if grammatical_case == :nominative
            raise UnsupportedOptionError, "case: #{grammatical_case.inspect} is not supported for decimals" if decimal_part?

            rules(case_words).spell(number, cardinal_set)
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
            gender = @options.gender.result
            "genders.#{gender}" if @translations.t(:genders, default: {}).key?(gender)
          end

          def rules(words = nil)
            Rules.new(@translations, @translations.t(:mega).size * 3, words: words)
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
