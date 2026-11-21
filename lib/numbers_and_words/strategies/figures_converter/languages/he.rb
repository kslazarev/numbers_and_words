# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        # Hebrew counts in groups of three digits. The number takes the gender of what is counted, feminine
        # by default, as when counting; multipliers of אלף, מיליון and larger are masculine. The conjunction ו
        # joins the last part of each group ("עשרים ואחת") and a single last part to the rest of the number
        # ("אלף ואחת"). Words are in logical order, without bidirectional control characters.
        class He < Base
          MAX = 10**15

          def words
            number = @figures.to_a.reverse.join.to_i
            raise RangeError, "Hebrew numbers must be below 10**#{Math.log10(MAX).to_i}" if number >= MAX
            return zero_words if number.zero?

            number_words(number)
          end

          private

          def zero_words
            @options.remove_zero.result ? '' : @translations.ones(0, gender)
          end

          def number_words(number)
            *phrases, last = phrases(number)
            last = [union(last.first)] if last.size == 1 && phrases.any?
            [*phrases, last].map { |phrase| join(phrase) }.join(' ')
          end

          # The parts of each nonzero group, from the largest scale down.
          def phrases(number)
            number.digits(1000).each_with_index.reject { |group, _capacity| group.zero? }.reverse.map do |group, capacity|
              capacity.zero? ? group_parts(group, gender) : [scale_words(group, capacity)]
            end
          end

          # A group of up to three digits as its parts: hundreds, tens and ones, with 11 to 19 as one part.
          def group_parts(group, gender)
            hundreds, rest = group.divmod(100)
            parts = []
            parts << @translations.hundreds(hundreds) unless hundreds.zero?
            parts.concat(rest_parts(rest, gender))
          end

          def rest_parts(rest, gender)
            return [] if rest.zero?
            return [@translations.ones(rest, gender)] if rest <= 10
            return [@translations.teens(rest, gender)] if rest < 20

            tens, ones = rest.divmod(10)
            [@translations.tens(tens), (@translations.ones(ones, gender) unless ones.zero?)].compact
          end

          # A multiple of a thousand, million or larger: אלפיים, שלושת אלפים, שני מיליון, עשרים ואחד אלף.
          def scale_words(group, capacity)
            return @translations.thousands(group) if capacity == 1 && group <= 10

            scale = @translations.mega(capacity)
            return scale if group == 1
            return "#{@translations.t(:two)} #{scale}" if group == 2

            "#{join(group_parts(group, :male))} #{scale}"
          end

          # Parts are separated by spaces, and the last of several takes the conjunction ו.
          def join(parts)
            return parts.first if parts.size == 1

            [*parts[0..-2], union(parts.last)].join(' ')
          end

          def union(word)
            "#{@translations.t(:union)}#{word}"
          end

          def gender
            @options.gender.result
          end
        end
      end
    end
  end
end
