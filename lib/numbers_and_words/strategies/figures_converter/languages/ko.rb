# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        # Korean reads Sino-Korean numbers grouped by ten thousands, with the scales 만 (10^4), 억 (10^8), 조 (10^12),
        # 경 (10^16) and so on up to 극 (10^48). 일 is not read before 십, 백 and 천 (십일, 백, 천), nor before 만
        # (만, 만 일), but is before larger scales (일억, 일조). Skipped places are not read (백일), and groups are
        # separated by a space, as Korean spacing rules write numbers in units of 만 (만 이천삼백사십오).
        class Ko < Base
          include Myriad

          private

          def number_words(groups)
            groups.reject { |group, _index| group.zero? }.map do |group, index|
              index.zero? ? group_words(group, index) : group_words(group, index) + @translations.scale(index)
            end.join(' ')
          end

          def group_words(group, index)
            return '' if group == 1 && index == 1

            group_digits(group).reject { |digit, _power| digit.zero? }.map do |digit, power|
              power.positive? ? "#{digit_word(digit) unless digit == 1}#{@translations.place(power)}" : digit_word(digit)
            end.join
          end
        end
      end
    end
  end
end
