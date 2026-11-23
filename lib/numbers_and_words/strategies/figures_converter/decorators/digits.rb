# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Decorators
        # The fractional part digit by digit, including leading zeros, joined by numbers.word_separator: Finnish,
        # Norwegian, Hindi, Bengali, Urdu, Indonesian, Malay, Thai ("สามจุดศูนย์ห้า"), Lao, Khmer and Burmese.
        module Digits
          class Fractional < Base
            def run
              length = @options[:fractional][:length].to_i
              digits = @strategy.figures.reverse.join.rjust(length, '0')
              digits.chars.map { |digit| @strategy.translations.ones(digit.to_i) }.join(I18n.word_separator)
            end
          end
        end
      end
    end
  end
end
