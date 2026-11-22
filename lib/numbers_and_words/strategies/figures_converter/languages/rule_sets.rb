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

          # Whether remove_zero: true still spells the ordinal of zero, as remove_zero: {keeps_ordinal_zero: true}
          # under numbers.supported_options declares.
          def keeps_ordinal_zero?
            declared = OptionsValidation.declared_options(I18n.local_language)[:remove_zero]
            declared.is_a?(::Hash) && declared[:keeps_ordinal_zero] == true
          end

          # The rule set of the gender, such as cardinal-female, where the locale file has one, or else cardinal. An
          # animate accusative takes the genitive of a final "one", and of "two", "three" and "four" alone.
          def cardinal_set
            gender = @options.gender&.result
            return 'cardinal' unless gender

            animate = grammatical_case == :accusative && @options.animate&.result
            set = "cardinal-#{gender}#{'-animate' if animate}"
            locale_words(:rules).include?(set.to_sym) ? set : 'cardinal'
          end

          def case_words
            "cases.#{grammatical_case}" if locale_words(:cases).include?(grammatical_case)
          end

          def gender_words
            gender = @options.gender&.result
            "genders.#{gender}" if locale_words(:genders).include?(gender)
          end

          def rules(*words)
            Rules.new(@translations, limit, words: words.compact, compiled: locale)
          end

          # Numbers stop below the first scale word past the last in numbers.mega, if the locale lists them.
          def limit
            locale.fetch(:limit) do
              mega = @translations.t(:mega, default: nil)
              locale[:limit] = mega && (mega.size * 3)
            end
          end

          # The cases or genders with words of their own.
          def locale_words(key)
            locale[key] ||= @translations.t(key, default: {}).keys
          end

          def ordinals
            locale[:ordinals] ||= super
          end

          # Data about the current locale's numbers, kept with its compiled rule sets.
          def locale
            @locale ||= Rules.compiled(@translations)
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
