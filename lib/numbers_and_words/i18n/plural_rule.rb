# frozen_string_literal: true

module NumbersAndWords
  module I18n
    # The plural category of a count from rules in a subset of the Unicode CLDR plural syntax, under numbers.plural
    # in a locale file: each category's condition in order, and other for a count that matches none.
    #
    #   one: n % 10 = 1 and n % 100 != 11
    #   few: n % 10 = 2,3,4 and n % 100 != 12,13,14
    #
    # A condition is relations joined by "and", then by "or". A relation compares an operand, optionally modulo a
    # number, with a list: n is the count, i its absolute integer part and v 0 for an integer and 1 otherwise. In
    # a list, 2,3,4 matches those values and 2..4 any value between them, as a decimal count can be.
    class PluralRule
      RELATION = /\A([niv])(?:\s*%\s*(\d+))?\s*(!=|=)\s*(\S+)\z/

      def initialize(categories)
        @categories = categories.map { |category, condition| [category.to_sym, parse(condition.to_s)] }
      end

      def to_proc
        categories = @categories
        ->(count) { categories.find { |_, condition| condition.call(count) }&.first || :other }
      end

      private

      def parse(condition)
        alternatives = condition.split(/\s+or\s+/).map { |all| all.split(/\s+and\s+/).map { |relation| relation(relation.strip) } }
        ->(count) { alternatives.any? { |relations| relations.all? { |relation| relation.call(count) } } }
      end

      def relation(text)
        operand, modulo, operator, values = text.match(RELATION)&.captures || raise(ArgumentError, "Invalid plural relation: #{text}")
        matches = values.split(',').map { |value| range(value) }
        equal = operator == '='
        lambda do |count|
          value = operand_value(operand, count)
          value %= modulo.to_i if modulo
          matches?(matches, value) == equal
        end
      end

      def matches?(matches, value)
        matches.any? { |match| match.is_a?(Range) ? match.cover?(value) : match == value }
      end

      def range(value)
        first, last = value.split('..').map(&:to_i)
        last ? first..last : first
      end

      def operand_value(operand, count)
        case operand
        when 'n' then count
        when 'i' then count.abs.to_i
        else count.is_a?(::Integer) ? 0 : 1
        end
      end
    end
  end
end
