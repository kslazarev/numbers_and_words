module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        class Hu < Base
          include Families::Latin
          #include Extensions::Options::Fractional
          #include NumbersAndWords::Translations::Hu

          private

          def print_words
            inner_reverse_words.reverse.join(greater_than_2000? && '-' || '')
          end

          def inner_reverse_words
            @strings.collect { |iteration| iteration.reverse.join }
          end

          def greater_than_2000?
            figures.length > 4 || (figures.length == 4 && figures.last >= 2)
          end

          def strings_logic
            if figures.capacity_count
              number_without_capacity_to_words + complex_number_to_words
            elsif figures.hundreds
              [hundreds_number_to_words]
            elsif figures.tens or figures.ones
              [simple_number_to_words]
            else
              []
            end
          end

          def complex_number_to_words
            count = figures.capacity_count
            (1..count).map { |capacity| capacity_iteration(capacity).flatten }.reject(&:empty?)
          end

          def simple_number_to_words
            if figures.teens || figures.tens
              [complex_tens]
            elsif figures.ones
              [translations.ones(figures.ones)]
            else
              []
            end
          end
        end
      end
    end
  end
end
