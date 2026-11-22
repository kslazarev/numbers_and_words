# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        # Chinese, Japanese and Korean group numbers by 10,000 (see their rule sets) and read the fractional part
        # of a decimal digit by digit.
        module Myriad
          include RuleSets

          GROUP = 10_000

          def fractional_words(length)
            @figures.to_a.reverse.join.rjust(length, '0').chars.map { |digit| digit_word(digit.to_i) }.join
          end

          private

          def cardinal_set
            'cardinal'
          end

          def digit_word(digit)
            @translations.ones(digit)
          end

          # Numbers stop below the first group past the last scale word in the locale file.
          def check_scale!(name)
            index = ordinal_integer.digits(GROUP).size - 1
            return if index < scales.size

            raise RangeError, "10^#{index * 4} is beyond the largest #{name} scale"
          end
        end
      end
    end
  end
end
