# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        # Slovak writes numbers below a million as one word ("dvetisícdvestotridsaťštyri") and millions and larger
        # as separate words ("dva milióny tristotisíc"). Scale words take the singular after one, which is omitted
        # ("tisíc", "milión"), the nominative plural after 2 to 4 ("dva milióny") and the genitive plural otherwise
        # ("päť miliónov", "dvadsaťjeden miliónov"). Ordinals make the last group ordinal ("stodvadsiaty prvý"),
        # and a round scale joins its multiplier ("dvojtisíci", "päťmiliónty").
        class Sk < Base
          MAX = 10**21

          def words
            number = @figures.to_a.reverse.join.to_i
            raise Translations::Families::Base.range_error(Math.log10(MAX).to_i) if number >= MAX
            return zero_words if number.zero?

            ordinal? ? ordinal_words(number) : cardinal_words(groups(number))
          end

          private

          def zero_words
            return declined(t(:ordinals)[:ones][0]) if ordinal?

            @options.remove_zero.result ? '' : t(:ones)[0]
          end

          # The nonzero groups of three digits with their capacity, from the largest down.
          def groups(number)
            number.digits(1000).each_with_index.reject { |group, _capacity| group.zero? }.reverse
          end

          # Millions and larger are separate words; thousands and the last group form one word.
          def cardinal_words(groups, last = nil)
            large, small = groups.partition { |_group, capacity| capacity >= 2 }
            words = large.map { |group, capacity| scale_words(group, capacity) }
            words << [*small.map { |group, capacity| capacity.zero? ? group_words(group, gender) : scale_words(group, capacity) }, last].join
            words.reject(&:empty?).join(' ')
          end

          def scale_words(group, capacity)
            return t(:mega)[capacity] if group == 1

            scale = capacity == 1 ? t(:mega)[1] : t(:megas)[@translations.form(group)][capacity]
            [group_words(group, multiplier_gender(capacity)), scale].join(capacity == 1 ? '' : ' ')
          end

          # Feminine scale words take "dve" but keep "jeden" in compounds ("dvetisíc", "dvadsaťjedentisíc", "dve miliardy").
          def multiplier_gender(capacity)
            t(:mega_gender)[capacity] == 'female' ? :two_female : :male
          end

          def group_words(group, gender)
            hundreds, rest = group.divmod(100)
            "#{t(:hundreds)[hundreds] unless hundreds.zero?}#{rest_words(rest, gender) unless rest.zero?}"
          end

          def rest_words(rest, gender)
            return ones(rest, gender) if rest < 10
            return t(:teens)[rest - 10] if rest < 20

            tens, ones = rest.divmod(10)
            "#{t(:tens)[tens]}#{ones(ones, gender) unless ones.zero?}"
          end

          def ones(digit, gender)
            return t(:gender)[:female][2] if gender == :two_female && digit == 2

            digit.between?(1, 2) && %i[female neuter].include?(gender) ? t(:gender)[gender][digit] : t(:ones)[digit]
          end

          def ordinal_words(number)
            *rest, (group, capacity) = groups(number)
            last = capacity.zero? ? last_group_ordinal(group) : scale_ordinal(group, capacity)
            return cardinal_words(rest, last) if capacity < 2

            [cardinal_words(rest), last].reject(&:empty?).join(' ')
          end

          # "stodvadsiaty prvý": hundreds stay cardinal, the tens and ones are ordinal.
          def last_group_ordinal(group)
            hundreds, rest = group.divmod(100)
            return declined(ordinals[:hundreds][hundreds]) if rest.zero?

            "#{t(:hundreds)[hundreds] unless hundreds.zero?}#{rest_ordinal(rest)}"
          end

          def rest_ordinal(rest)
            return ordinal(:ones, rest) if rest < 10
            return ordinal(:teens, rest - 10) if rest < 20

            tens, ones = rest.divmod(10)
            [ordinal(:tens, tens), (ordinal(:ones, ones) unless ones.zero?)].compact.join(' ')
          end

          def ordinal(key, index)
            declined(ordinals[key][index])
          end

          # "tisíci", "dvojtisíci", "päťmiliónty": the multiplier joins the ordinal scale word, with 2 to 4 as "dvoj", "troj", "štvor".
          def scale_ordinal(group, capacity)
            scale = declined(ordinals[:mega][capacity])
            return scale if group == 1

            ones = group % 10
            return "#{group_words(group - ones, :male)}#{ordinals[:combining][ones]}#{scale}" if ones.between?(2, 4) && !(group % 100).between?(12, 14)

            "#{group_words(group, :male)}#{scale}"
          end

          # The ordinal is an adjective in the gender asked for: "prvý", "prvá", "prvé"; "tretí", "tretia", "tretie".
          def declined(word)
            return word if gender == :male

            female = gender == :female
            return "#{word.delete_suffix('ý')}#{female ? 'á' : 'é'}" if word.end_with?('ý')
            return "#{word.delete_suffix('í')}#{female ? 'ia' : 'ie'}" if word.end_with?('í')

            "#{word[0..-2]}#{female ? 'a' : 'e'}"
          end

          def ordinals
            t(:ordinals)
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
