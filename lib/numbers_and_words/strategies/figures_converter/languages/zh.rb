# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        # Spells each group of four digits from the rule sets in numbers.zh.yml (see RuleSets), followed by its
        # scale word: 万 for the first group, then 亿 for every two more, as in 万亿 (10**12) and 亿亿 (10**16). 零 stands
        # for the zeros before a group below 1,000 or after a group of zeros ("一千零一", "一亿零五万零三"). The first
        # group starts with 十 for 10 to 19 ("十五万"), the others with 一十 ("一亿零一十五万").
        class Zh < Base
          include Myriad

          private

          def ordinal(number)
            "#{@translations.t(:ordinal_prefix)}#{cardinal(number)}"
          end

          def cardinal(number)
            groups = number.digits(GROUP).each_with_index.select { |group, _index| group.positive? }.reverse
            return rules.spell(0, 'cardinal') if groups.empty?

            previous = [nil, *groups.map(&:last)]
            groups.zip(previous).map { |(group, index), before| group_words(group, index, before) }.join
          end

          # A group and its scale word, after 零 for a gap since the group before it, at index before.
          def group_words(group, index, before)
            zero = before && (before - index > 1 || group < 1000)
            "#{@translations.t(:zero) if zero}#{rules(*option_words).spell(group, before ? 'group' : 'cardinal')}#{scale(index)}"
          end

          def scale(index)
            [(@translations.t(:ten_thousand) if index.odd?), @translations.t(:hundred_million) * (index / 2)].join
          end
        end
      end
    end
  end
end
