# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Decorators
        # Included in fractional decorators that define fraction_length.
        # Reads the fractional part after a decimal point ("vingt-et-un virgule zéro cinq") unless fraction: true asks
        # for a fraction ("vingt-et-un et cinq centièmes").
        module DecimalPoint
          # Up to three decimal places are read as a number after one zero for each leading zero
          # ("virgule zéro cinq", "virgule soixante-dix-sept"); longer ones digit by digit.
          NUMBER_PLACES = 3

          private

          def fraction?
            @options[:fraction]
          end

          def decimal_point_words(words)
            return decimal_point_digits if fraction_length > NUMBER_PLACES

            [*Array.new(leading_zeros) { @strategy.translations.zero }, words].join(' ')
          end

          # The fractional part read digit by digit, as English does after "point".
          def decimal_point_digits
            [*Array.new(leading_zeros, 0), *@strategy.figures.reverse].map { |digit| Wrappers::Integer.new(digit).to_words }.join(' ')
          end

          def leading_zeros
            fraction_length - @strategy.figures.length
          end
        end
      end
    end
  end
end
