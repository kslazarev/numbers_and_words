module NumbersAndWords
  module Strategies
    module Families
      module Base

        private

        def strings
          if figures.capacity_count
            number_without_capacity_to_words + complex_number_to_words
          elsif figures.hundreds
            hundreds_number_to_words
          elsif figures.tens or figures.ones
            simple_number_to_words
          else
            []
          end
        end

        def complex_number_to_words
          (1..figures.capacity_count).map{|capacity| capacity_iteration(capacity)}.flatten
        end

        def capacity_iteration capacity
          words = []
          capacity_words = words_in_capacity(capacity)
          words.push(translation_megs(capacity)) unless capacity_words.empty?
          words + capacity_words
        end

        def words_in_capacity capacity = 0
          save_parent_figures do |parent_figures|
            @figures = parent_figures.figures_array_in_capacity(capacity)
            strings
          end
        end

        alias_method :number_without_capacity_to_words, :words_in_capacity

        def hundreds_number_to_words
          simple_number_to_words + [translation_hundreds(figures.hundreds)]
        end

        def complex_tens
          figures.ones ?
            translation_tens_with_ones(figures.tens_with_ones) :
            translation_tens(figures.tens)
        end

        def simple_number_to_words
          if figures.teens
            [translation_teens(figures.ones)]
          elsif figures.tens
            [complex_tens]
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
end
