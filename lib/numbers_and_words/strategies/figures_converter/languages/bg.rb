# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        # Bulgarian counts in groups of three digits. "и" joins the last part of each group ("двадесет и един",
        # "сто и пет") and a last group of one part to the rest of the number ("хиляда и един", "две хиляди и
        # триста"). The last group takes the gender asked for; хиляда is feminine ("две хиляди", "двадесет и една
        # хиляди") and larger scale words are masculine ("два милиона"). Ordinals make the last word ordinal
        # ("двадесет и първи"), and a round scale joins its multiplier ("двехиляден").
        class Bg < Base
          MAX = 10**21

          def words
            number = @figures.to_a.reverse.join.to_i
            raise Translations::Families::Base.range_error(Math.log10(MAX).to_i) if number >= MAX

            text = number.zero? ? zero_words : number_words(number)
            ordinal? ? ordinal_words(text) : text
          end

          private

          def zero_words
            @options.remove_zero.result && !ordinal? ? '' : t(:ones)[0]
          end

          def number_words(number)
            phrases = groups(number).map { |group, capacity| capacity.zero? ? group_parts(group, gender) : scale_parts(group, capacity) }
            *head, last = phrases.map { |parts| join(parts) }
            last = "#{t(:union)} #{last}" if head.any? && phrases.last.size == 1
            [*head, last].join(' ')
          end

          # The nonzero groups of three digits with their capacity, from the largest down.
          def groups(number)
            number.digits(1000).each_with_index.reject { |group, _capacity| group.zero? }.reverse
          end

          # A multiple of a scale word as one part when its multiplier is one word ("пет хиляди"), so that "и" can join it.
          def scale_parts(group, capacity)
            return [capacity == 1 ? t(:mega)[1] : "#{t(:ones)[1]} #{t(:mega)[capacity]}"] if group == 1

            parts = group_parts(group, capacity == 1 ? :female : :male)
            words = "#{join(parts)} #{t(:megas)[capacity]}"
            parts.size == 1 ? [words] : [words, nil]
          end

          def group_parts(group, gender)
            hundreds, rest = group.divmod(100)
            [(t(:hundreds)[hundreds] unless hundreds.zero?), *rest_parts(rest, gender)].compact
          end

          def rest_parts(rest, gender)
            return [] if rest.zero?
            return [ones(rest, gender)] if rest < 10
            return [t(:teens)[rest - 10]] if rest < 20

            tens, ones = rest.divmod(10)
            [t(:tens)[tens], (ones(ones, gender) unless ones.zero?)]
          end

          def ones(digit, gender)
            digit <= 2 && gender != :male ? t(:gender)[gender][digit] : t(:ones)[digit]
          end

          def join(parts)
            parts = parts.compact
            return parts.first if parts.size == 1

            [*parts[0..-2], t(:union), parts.last].join(' ')
          end

          def ordinal_words(text)
            words = text.split
            ordinals = t(:ordinals)
            scale = ordinals[:scales][words.last.to_sym]
            return declined(scale_ordinal(words, scale)) if scale

            [*words[0..-2], declined(ordinals[:words][words.last.to_sym])].join(' ')
          end

          # "хиляден", "милионен", or the multiplier joined to the scale ordinal ("двехиляден", "петмилионен").
          def scale_ordinal(words, scale)
            return scale if words.size == 1

            *head, multiplier, _scale = words
            return [*head, multiplier, scale].join(' ') if multiplier == t(:union)
            return [*head, scale].join(' ') if multiplier == t(:ones)[1] && head.last != t(:union)

            [*head, "#{combining(multiplier)}#{scale}"].join(' ')
          end

          def combining(multiplier)
            t(:ordinals)[:combining].fetch(multiplier.to_sym, multiplier)
          end

          # The ordinal is an adjective: "първи", "първа", "първо"; "стотен", "стотна", "стотно".
          def declined(text)
            return text if gender == :male

            *head, word = text.split
            [*head, declined_word(word)].join(' ')
          end

          def declined_word(word)
            ending = gender == :female ? 'а' : 'о'
            return "#{word}#{ending}" if word.end_with?('ев')
            return "#{word.delete_suffix('ен')}н#{ending}" if word.end_with?('ен')

            "#{word.delete_suffix('и')}#{ending}"
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
