# frozen_string_literal: true

module NumbersAndWords
  module Translations
    class It < Base
      include NumbersAndWords::Translations::Families::Latin
      include NumbersAndWords::Translations::Extensions::FractionSignificance

      def tens_with_ones(numbers, _options = {})
        number_ones, number_tens = numbers
        # Drop final vowel from tens before "uno" or "otto"
        if [1, 8].include?(number_ones)
          tens_word = t(:tens)[number_tens]
          tens_word = tens_word.chomp('i').chomp('a') # Remove final vowel
          "#{tens_word}#{t(:ones)[number_ones]}"
        else
          super(numbers, separator: '')
        end
      end

      def hundreds(number, _options = {})
        return t(:hundreds) if number == 1

        # Join without space: "novecento" not "nove cento"
        [t(:ones)[number], t(:hundreds)].join
      end
    end
  end
end
