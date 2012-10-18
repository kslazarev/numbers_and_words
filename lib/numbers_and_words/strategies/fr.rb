module NumbersAndWords
  module Strategies
    class Fr < Base
      include Families::Latin
      include NumbersAndWords::TranslationsHelpers::Fr

      private

      def capacity_iteration capacity
        words = []
        capacity_words = words_in_capacity(capacity)
        words.push(translation_megs(capacity)) unless capacity_words.empty?
        words += capacity_words unless is_a_thousand?(capacity) and is_a_one?(capacity_words)
        words
      end

      def is_a_one? capacity_words
        [t(:ones)[1]] == capacity_words
      end

      def is_a_thousand? capacity
        FiguresArray::THOUSAND_CAPACITY == capacity
      end

      def hundreds_number_to_words
        simple_number_to_words + [
          translation_hundreds(figures.hundreds, simple_number_to_words.empty?)
        ]
      end
    end
  end
end
