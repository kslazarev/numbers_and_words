# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        # Thai groups digits by millions: each group of up to six digits uses the places สิบ (10), ร้อย (100),
        # พัน (1,000), หมื่น (10,000) and แสน (100,000), and ล้าน (1,000,000) repeats for larger numbers.
        # Words are written without spaces.
        class Th < Base
          MILLION = 1_000_000

          def words
            number = @figures.to_a.reverse.join.to_i
            text = number.zero? ? zero_words : number_words(number)
            ordinal? ? "#{@translations.t(:ordinal_prefix)}#{text}" : text
          end

          private

          # remove_zero: true omits a zero integral part; the fractional part is read by its decorator.
          def zero_words
            @options.remove_zero.result ? '' : @translations.ones(0)
          end

          # Each group of six digits is followed by ล้าน once per million it is worth.
          def number_words(number)
            number.digits(MILLION).each_with_index.reverse_each.map do |group, millions|
              group.zero? ? '' : "#{group_words(group)}#{@translations.t(:million) * millions}"
            end.join
          end

          def group_words(group)
            group.digits.each_with_index.reverse_each.map { |digit, power| digit_words(digit, power, group) }.join
          end

          def digit_words(digit, power, group)
            return '' if digit.zero?
            return @translations.tens(digit) if power == 1
            return digit == 1 && group > 1 ? @translations.t(:final_one) : @translations.ones(digit) if power.zero?

            "#{@translations.ones(digit)}#{@translations.place(power)}"
          end

          # Ordinals apply to integers, not to either part of a decimal.
          def ordinal?
            @options.ordinal.result && @options.options[:integral].nil? && @options.options[:fractional].nil?
          end
        end
      end
    end
  end
end
