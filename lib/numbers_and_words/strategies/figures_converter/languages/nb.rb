# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        # Norwegian Bokmål counts in groups of three digits with the modern compounds ("tjueen", not "en og tjue").
        # "og" joins tens and ones to hundreds ("hundre og en") and a last group below one hundred to the rest of the
        # number ("tusen og en"). A leading hundred or thousand has no "ett" ("hundre", "tusen"); larger scale words
        # are nouns that take "en" and the plural ("en million", "to millioner").
        class Nb < Base
          MAX = 10**21

          def words
            number = @figures.to_a.reverse.join.to_i
            raise Translations::Families::Base.range_error(Math.log10(MAX).to_i) if number >= MAX

            text = number.zero? ? zero_words : number_words(number)
            ordinal? ? ordinal_words(text) : text
          end

          private

          def zero_words
            @options.remove_zero.result ? '' : t(:ones)[0]
          end

          def number_words(number)
            groups = number.digits(1000).each_with_index.reject { |group, _capacity| group.zero? }.reverse
            words = groups.each_with_index.map do |(group, capacity), index|
              capacity.zero? ? last_group_words(group, index.zero?) : scale_words(group, capacity, index.zero?)
            end
            words.join(' ')
          end

          def last_group_words(group, first)
            words = group_words(group, first, last: true)
            group < 100 && !first ? "#{t(:union)} #{words}" : words
          end

          def scale_words(group, capacity, first)
            if capacity == 1
              group == 1 ? one_scale(t(:mega)[1], first) : "#{group_words(group, first, neuter: true)} #{t(:mega)[1]}"
            else
              group == 1 ? "#{t(:ones)[1]} #{t(:mega)[capacity]}" : "#{group_words(group, first)} #{t(:megas)[capacity]}"
            end
          end

          # "hundre" and "tusen" at the start of a number, "ett hundre" and "ett tusen" after a larger part.
          def one_scale(word, first)
            first ? word : "#{t(:one)[:neuter]} #{word}"
          end

          # tusen is neuter, so a final one before it is ett ("hundre og ett tusen").
          def group_words(group, first, last: false, neuter: false)
            hundreds, rest = group.divmod(100)
            parts = []
            parts << hundreds_words(hundreds, first) unless hundreds.zero?
            parts << t(:union) if hundreds.positive? && rest.positive?
            parts << (rest == 1 && neuter ? t(:one)[:neuter] : rest_words(rest, last)) if rest.positive?
            parts.join(' ')
          end

          def hundreds_words(hundreds, first)
            hundreds == 1 ? one_scale(t(:hundred), first) : "#{t(:ones)[hundreds]} #{t(:hundred)}"
          end

          def rest_words(rest, last)
            return t(:one)[gender] if rest == 1 && last
            return t(:ones)[rest] if rest < 10
            return t(:teens)[rest - 10] if rest < 20

            tens, ones = rest.divmod(10)
            "#{t(:tens)[tens]}#{t(:ones)[ones] unless ones.zero?}"
          end

          # The last word becomes ordinal, or the ones of a compound ("tjueførste"); a lone "en million" reads "millionte".
          def ordinal_words(text)
            words = text.split
            words.shift if words.size == 2 && words.first == t(:ones)[1]
            *head, last = words
            [*head, ordinal_word(last)].join(' ')
          end

          def ordinal_word(word)
            table = t(:ordinals)[:words]
            return table[word.to_sym] if table.key?(word.to_sym)

            tens = t(:tens).find { |prefix| prefix != '_' && word.start_with?(prefix) && table.key?(word.delete_prefix(prefix).to_sym) }
            "#{tens}#{table[word.delete_prefix(tens).to_sym]}"
          end

          def ordinal?
            @options.ordinal.result && @options.options[:integral].nil? && @options.options[:fractional].nil?
          end

          def gender
            @options.gender.result
          end

          def t(key)
            @translations.t(key)
          end
        end
      end
    end
  end
end
