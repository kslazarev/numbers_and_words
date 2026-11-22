# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        module RuleSets
          # What the locale file declares about the options and decimals of a language: the words and rule sets an
          # option picks under numbers.supported_options, and the genders of a decimal under numbers.decimals.
          module Declarations
            private

            # The words under numbers.options.<option> of each declared option that is on, or numbers.options.<value>
            # of its value, such as French spelling: :traditional.
            def option_words
              scopes = locale_words(:options)
              declared_options.keys.filter_map do |name|
                value = @options.public_send(name)&.result
                key = value == true ? name : value
                "options.#{key}" if key.is_a?(::Symbol) && scopes.include?(key)
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
            # fraction: true, as Portuguese "dois inteiros e dois décimos".
            def decimal_gender
              part = decimal_part
              return unless part

              decimals = locale[:decimals] ||= @translations.t(:decimals, default: {})
              gender = decimals[:"#{part}_gender"]
              gender ||= decimals[:fraction_gender] if @options.options[:fraction]
              gender&.to_sym
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
