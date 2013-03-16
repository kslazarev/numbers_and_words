module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        module Families
          module Base
            include Helpers

            attr_accessor :current_capacity, :parent_figures

            def strings_logic
              if @figures.capacity_count
                number_without_capacity_to_words + complex_number_to_words
              elsif @figures.hundreds
                hundreds_number_to_words
              elsif @figures.tens or @figures.ones
                simple_number_to_words
              else
                []
              end
            end

            def complex_number_to_words
              (1..@figures.capacity_count).map { |capacity|
                @current_capacity = capacity
                capacity_iteration
              }.flatten
            end

            def capacity_iteration
              words = []
              capacity_words = words_in_capacity(@current_capacity)
              words.push(megs) unless capacity_words.empty?
              words + capacity_words
            end

            def words_in_capacity capacity = 0
              save_parent_figures do
                @figures = @parent_figures.figures_array_in_capacity(capacity)
                strings_logic
              end
            end

            alias_method :number_without_capacity_to_words, :words_in_capacity

            def hundreds_number_to_words
              simple_number_to_words + [hundreds]
            end

            def complex_tens
              @figures.ones ? tens_with_ones : tens
            end

            def simple_number_to_words
              if @figures.teens
                [teens]
              elsif @figures.tens
                [complex_tens]
              elsif @figures.ones
                [ones]
              else
                []
              end
            end

            def save_parent_figures
              @parent_figures = @figures
              result = yield
              @figures = @parent_figures
              result
            end
          end
        end
      end
    end
  end
end
