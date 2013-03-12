module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        module Families
          module Cyrillic

            attr_accessor :current_capacity

            private

            def complex_tens
              figures.ones ?
                translations.tens_with_ones(figures.tens_with_ones, gender) :
                translations.tens(figures.tens)
            end

            def simple_number_to_words
              if figures.teens
                [translations.teens(figures.teens)]
              elsif figures.tens
                [complex_tens]
              elsif figures.ones
                [translations.ones(figures.ones, gender)]
              else
                []
              end
            end

            def words_in_capacity capacity = 0
              @current_capacity = capacity
              super
            end

            def gender
              case current_capacity.to_i
              when 1
                :female
              when 0
                options.gender.result
              else
                :male
              end
            end

            def capacity_iteration capacity
              words = []
              capacity_words = words_in_capacity(capacity)
              unless capacity_words.empty?
                words.push translations.megs(capacity, figures.number_in_capacity(capacity))
              end
              words + capacity_words
            end
          end
        end
      end
    end
  end
end
