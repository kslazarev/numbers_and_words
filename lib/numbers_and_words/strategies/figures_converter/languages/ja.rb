# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        # Japanese groups digits by ten thousands, with the scales 万 (10^4), 億 (10^8), 兆 (10^12), 京 (10^16) and
        # so on up to 極 (10^48). 一 is not written before 十, 百 and 千 (十一, 百, 千) but is before every scale
        # (一万, 一億), skipped places are not read (百一, 一万一), and words are written without spaces.
        # script: :kana writes the reading in hiragana, with its sound changes (さんびゃく, いっちょう).
        class Ja < Base
          include Myriad

          private

          def number_words(groups)
            groups.reject { |group, _index| group.zero? }.map do |group, index|
              index.zero? ? group_words(group) : @translations.join(group_words(group), @translations.scale(index, script), script)
            end.join
          end

          def group_words(group)
            group_digits(group).reject { |digit, _power| digit.zero? }.map { |digit, power| @translations.digit(digit, power, script) }.join
          end

          def digit_word(digit)
            @translations.ones(digit, script)
          end

          def ordinal_prefix
            @translations.ordinal_prefix(script)
          end

          def script
            @options.script.result
          end
        end
      end
    end
  end
end
