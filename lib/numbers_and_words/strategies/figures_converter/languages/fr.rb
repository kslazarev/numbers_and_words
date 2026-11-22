# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        class Fr < Base
          def capacity_iteration
            words = []
            capacity_words = words_in_capacity(@current_capacity)
            words.push(megs) unless capacity_words.empty?
            words += capacity_words unless thousand? && one?
            words
          end

          # "cents" and "quatre-vingts" take a plural -s when they end the number or
          # precede a scale noun (millions, milliards), but not before "mille".
          def hundreds
            super({ pluralize: simple_number_to_words.empty? && !thousand? })
          end

          def tens
            super({ alone: thousand? ? false : nil })
          end

          # remove_zero: true omits a zero integral part.
          def zero
            return if @options.remove_zero.result

            ordinal? ? ordinal(super) : super
          end

          def megs
            super({ number: @figures.number_in_capacity(@current_capacity) })
          end

          # The 1990 spelling reform hyphenates every numeral in a compound number
          # ("trois-cent-vingt-et-un", "deux-cent-mille"), but not the nouns million,
          # milliard and larger ("deux millions vingt-et-un"). spelling: :traditional keeps
          # the earlier spelling ("trois cent vingt et un").
          def print_words
            words = @options.spelling.traditional? ? super : hyphenate(super)
            ordinal? && !words.empty? ? ordinal(words) : words
          end

          private

          def hyphenate(words)
            words.split.slice_when { |a, b| scale_noun?(a) || scale_noun?(b) }.map { |run| run.join('-') }.join(' ')
          end

          # Only the last word of an ordinal changes ("vingt-et-unième", "deux-centième"), except 1 alone ("premier").
          # A round scale noun drops its "un" ("millionième"), and its ordinal is a numeral that the 1990 reform
          # hyphenates to its multiplier ("deux-millionième"; traditional "deux millionième").
          def ordinal(words)
            return translations.t(:ordinal_first) if words == translations.ones(1)

            words = words.delete_prefix("#{translations.ones(1)} ") if words.count(' ') == 1
            *head, last = words.split(/(?<=[- ])/)
            [*hyphenate_scale_ordinal(head, last), ordinal_word(last)].join
          end

          def hyphenate_scale_ordinal(head, last)
            return head if head.empty? || !scale_noun?(last) || @options.spelling.traditional?

            [*head[0...-1], head.last.sub(/ \z/, '-')]
          end

          # Plurals ("vingts", "cents", "millions") become singular, a final "e" is dropped, and
          # "cinq" and "neuf" become "cinqu" and "neuv" before the suffix.
          def ordinal_word(word)
            word = word.delete_suffix('s') unless word == translations.ones(3)
            stem = translations.t(:ordinal_stems).fetch(word.to_sym) { word.delete_suffix('e') }
            "#{stem}#{translations.t(:ordinal_suffix)}"
          end

          def ordinal?
            @options.ordinal.result && @options.options[:integral].nil? && @options.options[:fractional].nil?
          end

          def scale_noun?(word)
            @scale_nouns ||= translations.t(:mega).drop(2).flat_map { |key| Array(translations.t(key).values) }
            @scale_nouns.include?(word)
          end

          def one?
            words_in_capacity(@current_capacity) == [translations.ones(1)]
          end

          def thousand?
            @current_capacity == FiguresArray::THOUSAND_CAPACITY
          end
        end
      end
    end
  end
end
