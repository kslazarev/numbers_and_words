module NumbersAndWords
  module Strategies
    class Ru < Base
      include NumbersAndWords::TranslationsHelpers::Ru

      def convert figures
        @figures = figures.reverse
        @words = strings

        @words.empty? ? zero : @words.reverse.join(' ')
      end

      private

      def strings gender = :male
        if figures.capacity_count
          complex_to_words
        elsif figures.hundreds
          simple_hundreds_to_words gender
        elsif figures.tens or figures.ones
          simple_to_words gender
        else
          []
        end
      end

      def complex_to_words
        words = []
        figures.capacity_count.times do |capacity|
          number_in_capacity_by_words = save_parent_figures do
            @figures = figures.figures_array_in_capacity(capacity)
            strings figures.is_a_thousand_capacity?(capacity) ? :female : :male
          end

          unless number_in_capacity_by_words.empty?
            if 0 < capacity
              words.push translation_megs(capacity, figures.number_for_gender(capacity))
            end
            words += number_in_capacity_by_words
          end
        end
        words
      end

      def simple_hundreds_to_words gender
        simple_to_words(gender) + [translation_hundreds(figures.hundreds)]
      end

      def simple_to_words gender
        if figures.teens
          [translation_teens(figures.ones)]
        elsif figures.tens
          figures.ones ?
            [translation_tens_with_ones(figures.tens_with_ones, gender)] :
            [translation_tens(figures.tens)]
        elsif figures.ones
          [translation_ones(figures.ones, gender)]
        else
          []
        end
      end

      def save_parent_figures
        parent_figures = @figures
        result = yield
        @figures = parent_figures
        result
      end
    end
  end
end
