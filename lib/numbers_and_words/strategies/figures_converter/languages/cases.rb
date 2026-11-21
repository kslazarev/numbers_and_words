# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        # Declines the cardinal words of an integer by the case: option, using numbers.cases in the locale file:
        # every numeral word through its words table, and every scale word through suffix tables applied to its
        # singular, singular after a numeral ending in one ("двадцати одной тысячи") and plural otherwise
        # ("двух тысяч"). A language prepends this module before Ordinals, which declines ordinals itself.
        module Cases
          def words
            text = super
            return text if grammatical_case == :nominative || ordinal_number?
            raise UnsupportedOptionError, "case: #{grammatical_case.inspect} is not supported for decimals" if decimal_part?

            declined_cardinal(text)
          end

          private

          def grammatical_case
            @options.options.fetch(:case, :nominative).to_sym
          end

          def decimal_part?
            !(@options.options[:integral].nil? && @options.options[:fractional].nil?)
          end

          def declined_cardinal(text)
            table = @translations.t(:cases)[grammatical_case]
            return text unless table

            words = text.split
            words[-1] = animate_word(table, words) if @options.animate&.result
            words.map { |word| table[:words][word.to_sym] || declined_scale(table, word) || word }.join(' ')
          end

          # An animate accusative takes the genitive of "один" ("двадцать одного"), and of "два", "три" and
          # "четыре" only alone; compound numbers ending in them keep the nominative ("двадцать два").
          def animate_word(table, words)
            word = words.last.to_sym
            table.fetch(:animate, {})[word] || (words.size == 1 && table.fetch(:animate_alone, {})[word]) || words.last
          end

          def declined_scale(table, word)
            singular, number = scale_forms[word]
            endings = singular && table.dig(:scales, number)
            endings && replace_suffix(singular, endings)
          end

          # Every form of every scale word: { "тысячи" => ["тысяча", :other] }.
          def scale_forms
            @scale_forms ||= @translations.t(:mega).drop(1).each_with_object({}) do |key, forms|
              plural = @translations.t(key)
              plural.each_value { |form| forms[form] ||= [plural[:one], :other] }
              forms[plural[:one]] = [plural[:one], :one]
            end
          end
        end
      end
    end
  end
end
