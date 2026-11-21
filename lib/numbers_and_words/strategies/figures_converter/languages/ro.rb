# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        # Romanian counts in groups of three digits. Numbers agree with the noun they count: mie is feminine
        # (o mie, două mii), and milion and larger scales are neuter, taking the masculine one and the feminine
        # two (un milion, două milioane). A count whose last two digits are 00 or 20 and above takes "de" before
        # the noun (douăzeci de mii, o sută de milioane), and one from 1 to 19 does not (nouăsprezece mii).
        # The last group takes the gender option, masculine by default (unu, doi, douăzeci și unu).
        class Ro < Base
          MAX = 10**18
          SCALE_GENDERS = { 1 => :female }.freeze

          def words
            number = @figures.to_a.reverse.join.to_i
            raise Translations::Families::Base.range_error(Math.log10(MAX).to_i) if number >= MAX
            return zero_words if number.zero?
            return ordinal_words(number) if ordinal?

            number_words(number, gender)
          end

          private

          def zero_words
            @options.remove_zero.result ? '' : @translations.zero
          end

          # Decimals, and either part of one, keep the cardinal form.
          def ordinal?
            @options.ordinal.result && @options.options[:integral].nil? && @options.options[:fractional].nil?
          end

          # The fractional part of a decimal counts nothing, so it keeps the masculine counting form.
          def gender
            @options.options[:fractional] ? :male : @options.gender.result
          end

          def number_words(number, gender)
            number.digits(1000).each_with_index.reject { |group, _capacity| group.zero? }.reverse.map do |group, capacity|
              capacity.zero? ? group_words(group, gender) : scale_words(group, capacity)
            end.join(' ')
          end

          # o mie, un milion, două mii, douăzeci și una de mii, douăzeci și unu de milioane.
          def scale_words(group, capacity)
            scale_gender = SCALE_GENDERS.fetch(capacity, :neuter)
            return "#{@translations.t(:one)[scale_gender]} #{@translations.mega(capacity)}" if group == 1

            of = @translations.t(:of) if (group % 100).zero? || group % 100 >= 20
            [group_words(group, scale_gender), of, @translations.mega(capacity, group)].compact.join(' ')
          end

          def group_words(group, gender)
            hundreds, rest = group.divmod(100)
            [(hundreds_words(hundreds) unless hundreds.zero?), rest_words(rest, gender)].compact.join(' ')
          end

          # sută is feminine: o sută, două sute.
          def hundreds_words(digit)
            one, many = @translations.t(:hundred)
            digit == 1 ? one : "#{@translations.ones(digit, :female)} #{many}"
          end

          def rest_words(rest, gender)
            return if rest.zero?
            return @translations.ones(rest, gender) if rest < 10
            return @translations.teens(rest, gender) if rest < 20

            tens, ones = rest.divmod(10)
            return @translations.tens(tens) if ones.zero?

            "#{@translations.tens(tens)} #{@translations.t(:union)} #{@translations.ones(ones, gender)}"
          end

          # Ordinals take the article al or a and change the last word: al doilea, al douăzeci și unulea,
          # a doua, a douăzeci și una. Neuter nouns take the masculine ordinal. "un" alone before a scale is dropped
          # (al milionulea), and o is kept (al o sutălea).
          def ordinal_words(number)
            form = @options.gender.result == :female ? :female : :male
            ordinals = @translations.t(:ordinals)
            return ordinals[:first][form] if number == 1

            *head, last = ordinal_cardinal(number, form)
            last = form == :female ? female_ordinal(last, ordinals) : male_ordinal(last, ordinals)
            [ordinals[:article][form], *head, last].join(' ')
          end

          def ordinal_cardinal(number, form)
            words = number_words(number, form).split
            words.size == 2 && words.first == @translations.t(:one)[:neuter] ? words.drop(1) : words
          end

          def male_ordinal(word, ordinals)
            return ordinals[:male_words][word.to_sym] if ordinals[:male_words].key?(word.to_sym)

            word.match?(/[aeiouăâî]\z/) ? "#{word}#{ordinals[:male_suffix]}" : "#{word}#{ordinals[:male_consonant_suffix]}"
          end

          # a doua, a treia, a patra, a cincea, a șasea, a opta, a douăzecea, a suta, a mia.
          def female_ordinal(word, ordinals)
            noun = ordinals[:female_nouns][word.to_sym]
            return noun if noun
            return word if word == @translations.ones(1, :female)
            return word.sub(/ă\z/, 'a') if word.end_with?('ă')
            return word.sub(/ci\z/, 'cea') if word.end_with?('ci')
            return word.sub(/u\z/, 'a') if word.end_with?('u')

            "#{word}a"
          end
        end
      end
    end
  end
end
