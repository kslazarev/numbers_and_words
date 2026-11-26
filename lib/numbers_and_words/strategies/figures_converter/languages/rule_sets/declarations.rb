# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        module RuleSets
          # What the locale file declares about the options and decimals of a language: the words and rule sets an
          # option picks under numbers.supported_options, and the genders of a decimal under numbers.decimals.
          module Declarations
            # The numbers.decimals keys of the gender of each part of a decimal, and of that part with fraction: true.
            PART_GENDERS = { integral: :integral_gender, fractional: :fractional_gender }.freeze
            FRACTION_PART_GENDERS = { integral: :fraction_integral_gender, fractional: :fraction_fractional_gender }.freeze

            private

            # The words under numbers.options.<option> of each declared option that is on, or numbers.options.<value>
            # of its value, such as French spelling: :traditional.
            def option_words
              scopes = locale_words(:options)
              options_with_words.filter_map do |name|
                value = @options.public_send(name)&.result
                key = value == true ? name : value
                "options.#{key}" if key.is_a?(::Symbol) && scopes.include?(key)
              end
            end

            # The declared options that are, or have a value or a default that is, a scope under numbers.options.
            def options_with_words
              locale[:options_with_words] ||= declared_options.filter_map do |name, declared|
                keys = declared.is_a?(::Hash) ? [name, *declared[:values], declared[:default]] : [name]
                name if keys.any? { |key| key.respond_to?(:to_sym) && locale_words(:options).include?(key.to_sym) }
              end
            end

            # The rule set with the suffix an option that is on names, such as cardinal-hundreds for
            # tens_of_hundreds: {rules: hundreds}, where the locale file has one.
            def with_option_rules(set)
              suffix = option_rules
              candidate = "#{set}-#{suffix}"
              suffix && locale_words(:rules).include?(candidate.to_sym) ? candidate : set
            end

            def option_rules
              declared_options.each { |name, declared| return declared[:rules] if declared.is_a?(::Hash) && declared[:rules] && @options.options[name] }
              nil
            end

            def declared_options
              OptionsValidation.declared_options(I18n.local_language)
            end

            # Whether remove_zero: true still spells the ordinal of zero, as remove_zero: {keeps_ordinal_zero: true}
            # under numbers.supported_options declares.
            def keeps_ordinal_zero?
              declared = declared_options[:remove_zero]
              declared.is_a?(::Hash) && declared[:keeps_ordinal_zero] == true
            end

            # The gender of the part of a decimal being spelled, under numbers.decimals in the locale file, or else the
            # gender option.
            def gender
              decimal_gender || @options.gender&.result
            end

            # integral_gender or fractional_gender for that part of a decimal, or fraction_gender for both parts with
            # fraction: true, as Portuguese "dois inteiros e dois décimos". With fraction: true, fraction_integral_gender
            # or fraction_fractional_gender comes first, as the masculine count of tenths in French "une et un dixième".
            def decimal_gender
              part = decimal_part
              return unless part

              decimals = locale[:decimals] ||= @translations.t(:decimals, default: {})
              part_gender(decimals, part)&.to_sym
            end

            def part_gender(decimals, part)
              return decimals[PART_GENDERS[part]] unless @options.options[:fraction]

              decimals[FRACTION_PART_GENDERS[part]] || decimals[PART_GENDERS[part]] || decimals[:fraction_gender]
            end

            def decimal_part
              %i[integral fractional].find { |part| @options.options[part] }
            end
          end
        end
      end
    end
  end
end
