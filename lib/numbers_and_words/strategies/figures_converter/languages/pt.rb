# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        class Pt < Base
          prepend Ordinals

          def hundreds
            super({ is_hundred: hundred?, is_one_hundred: one_hundred? })
          end

          def megs
            super({ number: @figures.number_in_capacity(@current_capacity) })
          end

          def zero
            super unless @options.remove_zero&.result
          end

          private

          def hundred?
            figures[0].zero? && figures[1].zero? && simple_number_to_words.empty?
          end

          def one_hundred?
            hundred? && figures[2] == 1
          end

          # Every part of a Portuguese ordinal is ordinal ("centésimo vigésimo primeiro"), and a multiplier of a
          # scale word is ordinal too ("segundo milésimo"), as in Brazilian Portuguese.
          def ordinal_words(text, number)
            return text if number.zero?

            number.digits(1000).each_with_index.reverse_each.filter_map do |group, power|
              group_ordinal(group, power) unless group.zero?
            end.join(' ')
          end

          def group_ordinal(group, power)
            return hundreds_ordinal(group) if power.zero?

            [(hundreds_ordinal(group) unless group == 1), ordinals[:mega][power]].compact.join(' ')
          end

          def hundreds_ordinal(group)
            digits = format('%03d', group).chars.map(&:to_i)
            %i[hundreds tens units].zip(digits).filter_map { |key, digit| ordinal_part(key, digit) }.join(' ')
          end
        end
      end
    end
  end
end
