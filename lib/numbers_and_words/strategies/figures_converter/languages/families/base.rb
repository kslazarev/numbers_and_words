module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        module Families
          module Base

            attr_accessor :current_capacity

            private

            def strings_logic
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
              (1..figures.capacity_count).map { |capacity|
                @current_capacity = capacity
                capacity_iteration(capacity)
              }.flatten
            end

            def capacity_iteration capacity
              words = []
              capacity_words = words_in_capacity(capacity)
              words.push(translations.megs(capacity)) unless capacity_words.empty?
              words + capacity_words
            end

            def words_in_capacity capacity = 0
              save_parent_figures do |parent_figures|
                @figures = parent_figures.figures_array_in_capacity(capacity)
                strings_logic
              end
            end

            alias_method :number_without_capacity_to_words, :words_in_capacity

            def hundreds_number_to_words
              simple_number_to_words + [translations.hundreds(figures.hundreds)]
            end

            def complex_tens
              figures.ones ?
                translations.tens_with_ones(figures.tens_with_ones) :
                translations.tens(figures.tens)
            end

            def simple_number_to_words
              if figures.teens
                [translations.teens(figures.ones)]
              elsif figures.tens
                [complex_tens]
              elsif figures.ones
                [translations.ones(figures.ones)]
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
  end
end
