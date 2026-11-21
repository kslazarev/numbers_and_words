# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        # Arabic reads groups of three digits from the largest, joining every part with و ("and"),
        # and puts ones before tens (21 is "واحد وعشرون"). A scale word takes the form its count requires:
        # singular for 1 (ألف), dual for 2 (ألفان), plural for 3 to 10 (ثلاثة آلاف) and accusative singular
        # for 11 to 99 (أحد عشر ألفًا). After round hundreds it is a singular genitive (مائة ألف, مائتا ألف).
        class Ar < Base
          THOUSAND = 1000
          ORDINALS = (1..99)

          def words
            number = @figures.to_a.reverse.join.to_i
            return ordinal_words(number) if @options.ordinal.result
            return @translations.ones(0) if number.zero?

            join(groups(number).each_with_index.reverse_each.map { |group, capacity| group_with_scale(group, capacity) })
          end

          private

          # The masculine definite ordinals: الأول, العاشر, الحادي عشر, الحادي والعشرون.
          def ordinal_words(number)
            raise RangeError, 'Arabic ordinals support 1 to 99' unless ORDINALS.cover?(number)

            tens, ones = number.divmod(10)
            return ordinal_below_twenty(number) if tens < 2
            return ordinals[:tens][tens] if ones.zero?

            join([ordinal_one(ones), ordinals[:tens][tens]])
          end

          def ordinal_below_twenty(number)
            return ordinals[:ones][number] if number < 10
            return ordinals[:ten] if number == 10

            "#{ordinal_one(number - 10)} #{ordinals[:teen]}"
          end

          # One is الحادي rather than الأول in compounds (الحادي عشر, الحادي والعشرون).
          def ordinal_one(ones)
            ones == 1 ? ordinals[:compound_one] : ordinals[:ones][ones]
          end

          def ordinals
            @translations.t(:ordinals)
          end

          # Groups of three digits, lowest first. Only numbers below the largest scale word's next power are supported.
          def groups(number)
            limit = @translations.scales + 1
            raise Translations::Families::Base.range_error(3 * limit) if number >= THOUSAND**limit

            number.digits(THOUSAND)
          end

          def group_with_scale(group, capacity)
            return if group.zero?
            return group_words(group) if capacity.zero?

            hundreds, rest = group.divmod(100)
            return counted(rest, capacity) if hundreds.zero?
            return round_hundreds(hundreds, capacity) if rest.zero?
            # 101,000 is "a hundred thousand and a thousand"; "مائة وألف" would read as 1,100.
            return join([round_hundreds(hundreds, capacity), counted(rest, capacity)]) if rest <= 2

            join([@translations.hundreds(hundreds), counted(rest, capacity)])
          end

          # Round hundreds take the singular genitive scale word, and 200 its construct form (مائتا ألف).
          def round_hundreds(hundreds, capacity)
            "#{hundreds == 2 ? @translations.t(:two_hundred_construct) : @translations.hundreds(hundreds)} #{scale(capacity, :singular)}"
          end

          # A count below 100 with its scale word. 1 and 2 are the singular and dual scale word alone.
          def counted(count, capacity)
            case count
            when 1 then scale(capacity, :singular)
            when 2 then scale(capacity, :dual)
            when 3..10 then "#{group_words(count)} #{scale(capacity, :plural)}"
            else "#{group_words(count)} #{scale(capacity, :accusative)}"
            end
          end

          def group_words(group)
            hundreds, rest = group.divmod(100)
            join([(@translations.hundreds(hundreds) if hundreds.positive?), (rest_words(rest) if rest.positive?)])
          end

          def rest_words(rest)
            tens, ones = rest.divmod(10)
            return @translations.ones(ones) if tens.zero?
            return @translations.teens(ones) if tens == 1
            return @translations.tens(tens) if ones.zero?

            join([@translations.ones(ones), @translations.tens(tens)])
          end

          def scale(capacity, form)
            @translations.scale(capacity, form)
          end

          def join(parts)
            parts.compact.join(" #{@translations.t(:union)}")
          end
        end
      end
    end
  end
end
