# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        # Greek counts in groups of three digits. Numbers agree with the noun they count, neuter by default as
        # when counting (ένα, τρία, τέσσερα, διακόσια, χίλια); gender: gives the masculine or feminine forms.
        # Thousands are the feminine noun χιλιάδες (δύο χιλιάδες, είκοσι μία χιλιάδες) except one thousand,
        # χίλια; millions and larger are neuter (ένα εκατομμύριο, δύο εκατομμύρια). εκατό becomes εκατόν before
        # the rest of its group (εκατόν ένα).
        class El < Base
          MAX = 10**15
          ORDINAL_LIMIT = 10_000

          def words
            number = @figures.to_a.reverse.join.to_i
            raise RangeError, 'Greek numbers must be below 10**15' if number >= MAX
            return zero_words if number.zero?
            return ordinal_words(number) if ordinal?

            number_words(number)
          end

          private

          def zero_words
            @options.remove_zero.result ? '' : @translations.zero
          end

          # Decimals, and either part of one, keep the cardinal form.
          def ordinal?
            @options.ordinal.result && @options.options[:integral].nil? && @options.options[:fractional].nil?
          end

          # The fractional part of a decimal counts nothing, so it keeps the neuter counting form.
          def gender
            @options.options[:fractional] ? :neuter : @options.gender.result
          end

          def number_words(number)
            number.digits(1000).each_with_index.reject { |group, _capacity| group.zero? }.reverse.map do |group, capacity|
              capacity.zero? ? group_words(group, gender) : scale_words(group, capacity)
            end.join(' ')
          end

          def scale_words(group, capacity)
            return @translations.t(:thousand)[gender] if capacity == 1 && group == 1

            scale_gender = capacity == 1 ? :female : :neuter
            "#{group_words(group, scale_gender)} #{@translations.mega(capacity, group)}"
          end

          def group_words(group, gender)
            hundreds, rest = group.divmod(100)
            [(hundreds_words(hundreds, rest, gender) unless hundreds.zero?), rest_words(rest, gender)].compact.join(' ')
          end

          def hundreds_words(digit, rest, gender)
            return @translations.t(:hundred_and) if digit == 1 && rest.positive?

            @translations.hundreds(digit, gender)
          end

          def rest_words(rest, gender)
            return if rest.zero?
            return @translations.ones(rest, gender) if rest < 10
            return @translations.teens(rest, gender) if rest < 20

            tens, ones = rest.divmod(10)
            [@translations.tens(tens), (@translations.ones(ones, gender) unless ones.zero?)].compact.join(' ')
          end

          # Every part of an ordinal is an ordinal word agreeing in gender: εικοστός πρώτος, χιλιοστή εκατοστή.
          # Greek ordinals of ten thousand and above are rare and raise RangeError.
          def ordinal_words(number)
            raise RangeError, 'Greek ordinals support numbers below 10,000' if number >= ORDINAL_LIMIT

            ordinals = @translations.t(:ordinals)
            ordinal_parts(number, ordinals).map { |word| inflect(word, ordinals[:endings]) }.join(' ')
          end

          def ordinal_parts(number, ordinals)
            thousands, rest = number.divmod(1000)
            hundreds, rest = rest.divmod(100)
            words = [ordinals[:thousands][thousands], ordinals[:hundreds][hundreds], *ordinal_rest(rest, ordinals)]
            words.reject { |word| word.nil? || word == '_' }
          end

          # ενδέκατος and δωδέκατος are single words; δέκατος τρίτος and εικοστός πρώτος are two.
          def ordinal_rest(rest, ordinals)
            return [ordinals[:teens][rest - 10]] if rest.between?(10, 12)

            tens, ones = rest.divmod(10)
            [ordinals[:tens][tens], ordinals[:ones][ones]]
          end

          def inflect(word, endings)
            return word if gender == :male

            ending, forms = endings.find { |key, _forms| word.end_with?(key.to_s) }
            "#{word.delete_suffix(ending.to_s)}#{forms[gender]}"
          end
        end
      end
    end
  end
end
