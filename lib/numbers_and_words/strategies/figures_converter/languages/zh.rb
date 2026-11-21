# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        # Simplified Chinese groups digits by ten thousands: each group of up to four digits uses the places
        # 十 (10), 百 (100) and 千 (1,000), and is followed by 万 (10^4), 亿 (10^8), 万亿 (10^12), 亿亿 (10^16) and so on.
        # A single 零 marks skipped places between nonzero digits (101 is 一百零一), a leading 一十 is read 十
        # (15 is 十五), and words are written without spaces.
        class Zh < Base
          include Myriad

          private

          # Groups of four digits, each followed by its scale. A group below 1,000 after a higher group
          # starts with skipped places, so it gets a 零 (10,001 is 一万零一).
          def number_words(groups)
            spell(groups.each_with_index.map do |(group, index), position|
              [group, -> { group_words(group, leading: position.zero?) + scale(index) }, group < 1000]
            end)
          end

          # A number from 10 to 19 at the start drops its leading 一 (15 is 十五, not 一十五).
          def group_words(group, leading:)
            text = spell(group_digits(group).map { |digit, power| [digit, -> { digit_word(digit) + place(power) }] })
            leading && (10..19).cover?(group) ? text.delete_prefix(digit_word(1)) : text
          end

          # Joins [value, words, gap_before] parts from the highest down, skipping zero values and writing
          # a single 零 between nonzero parts that skipped one or more places.
          def spell(parts)
            words = []
            gap = false
            parts.each do |value, text, gap_before|
              next gap = !words.empty? if value.zero?

              words << digit_word(0) if !words.empty? && (gap || gap_before)
              words << text.call
              gap = false
            end
            words.join
          end

          def place(power)
            power.zero? ? '' : @translations.place(power)
          end

          # 万 for odd groups, then one 亿 for every two groups: 万, 亿, 万亿, 亿亿, 万亿亿.
          def scale(index)
            "#{@translations.t(:ten_thousand) if index.odd?}#{@translations.t(:hundred_million) * (index / 2)}"
          end
        end
      end
    end
  end
end
