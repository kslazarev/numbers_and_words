module NumbersAndWords
  module Translations
    class Ka < Base
      include NumbersAndWords::Translations::Families::Latin
      TENS_VIGESIMAL_RANGES = [
        {
          range: Range.new(0, 4, true),
          name: :twenty,
          multiplicative: 2
        },
        {
          range: Range.new(0, 6, true),
          name: :forty,
          multiplicative: 4
        },
        {
          range: Range.new(0, 8, true),
          name: :sixty,
          multiplicative: 6
        },
        {
          range: Range.new(0, 9, false),
          name: :eighty,
          multiplicative: 8
        },
      ]

      def vigesimal_range number
        range = nil
        TENS_VIGESIMAL_RANGES.each do|item|
          if item[:range].include? number
            range = item
            break
          end
        end

        range
      end

      def tens_with_ones numbers, options = {}
        range = vigesimal_range(numbers[1])

        if numbers[1] - range[:multiplicative] > 0
          minor = teens(numbers)
        else
          minor = ones(numbers[0])
        end

        [t([:partials, range[:name]].join('.')), minor].join ''
      end

      def hundreds number, options = {}
        options[:prefix] ||= (options[:only_hundreds] == true) ? nil : :partials

        parts = [t([options[:prefix], :one_hundred].join('.'))]
        parts.unshift(ones(number, prefix: :partials)) if number > 1

        parts.join ''
      end

      def megs capacity, options = {}
        if capacity == 1
          t([options[:prefix], :one_thousand].join('.'))
        elsif capacity == 2
          t([options[:prefix], :one_million].join('.'))
        elsif capacity == 3
          t([options[:prefix], :one_billion].join('.'))
        end
      end
    end
  end
end
