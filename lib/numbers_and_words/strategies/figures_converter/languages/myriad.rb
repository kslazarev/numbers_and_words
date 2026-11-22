# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        # Shared by Chinese, Japanese and Korean, which group digits by ten thousands (myriads) rather than
        # thousands: each group of up to four digits uses the places 10, 100 and 1,000, and is followed by the
        # scale of its group (10^4, 10^8, 10^12 and so on). A language implements number_words(groups), and
        # reads decimals digit by digit through fractional_words.
        module Myriad
          GROUP = 10_000

          def words
            number = @figures.to_a.reverse.join.to_i
            text = number.zero? ? zero_words : number_words(groups(number))
            ordinal? && !text.empty? ? "#{ordinal_prefix}#{text}" : text
          end

          # The fractional part of a decimal, digit by digit and with its leading zeros: 3.05 ends with 0 and 5.
          def fractional_words(length)
            @figures.to_a.reverse.join.rjust(length, '0').chars.map { |digit| digit_word(digit.to_i) }.join
          end

          private

          # [group, index] pairs from the highest group down; group index 0 has no scale, 1 is 10^4, 2 is 10^8.
          def groups(number)
            number.digits(GROUP).each_with_index.reverse_each.to_a
          end

          # [digit, power] pairs of a group from the thousands down, including zero digits.
          def group_digits(group)
            group.digits.each_with_index.reverse_each.to_a
          end

          def digit_word(digit)
            @translations.ones(digit)
          end

          # remove_zero: true omits a zero integral part; the fractional part is read by its decorator.
          def zero_words
            @options.remove_zero.result ? '' : digit_word(0)
          end

          def ordinal_prefix
            @translations.t(:ordinal_prefix)
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
