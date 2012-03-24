module NumbersAndWords
  module Strategies
    class En < Base
      include NumbersAndWords::TranslationsHelpers::En
  
      attr_accessor :figures_in_previous_capacity
  
      def convert figures
        @figures = figures.reverse
  
        @words = strings
        @words.empty? ? zero : @words.reverse.join(' ')
      end
  
      private
  
      def strings
        if figures.capacity_count
          complex_to_words
        elsif figures.hundreds
          simple_hundreds_to_words
        elsif figures.tens or figures.ones
          simple_to_words
        else
          []
        end
      end
  
      def complex_to_words
        words = []
        figures.capacity_count.times do |capacity|
          number_in_capacity_by_words = save_parent_figures do |parent_figures|
            @figures = parent_figures.figures_array_in_capacity(capacity)
            strings
          end
  
          unless number_in_capacity_by_words.empty?
            words.push translation_megs(capacity) if 0 < capacity
            words += number_in_capacity_by_words
          end
        end
        words
      end
  
      def simple_hundreds_to_words
        simple_to_words + [translation_hundreds(figures.hundreds)]
      end
  
      def simple_to_words
        if figures.teens
          [translation_teens(figures.ones)]
        elsif figures.tens
          figures.ones ?
            [translation_tens_with_ones(figures.tens_with_ones)] :
            [translation_tens(figures.tens)]
        elsif figures.ones
          [translation_ones(figures.ones)]
        else
          []
        end
      end
  
      def save_parent_figures
        parent_figures = @figures
        result = yield(parent_figures)
        @figures = parent_figures
        result
      end
    end
  end
end
