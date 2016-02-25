module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        class Cs < Base
          include Families::Latin

          def capacity_iteration
            words = []
            capacity_words = words_in_capacity(@current_capacity)
            words.push megs unless capacity_words.empty?

            if 0 < @current_capacity
              capacity_words = capacity_words.map { |word|
                word.gsub(@translations.ones(1), @translations.one) unless is_a_thousand? and is_a_one?
              }.compact
            end

            words + capacity_words
          end

          def is_a_one?
            [translations.ones(1)] == words_in_capacity(@current_capacity)
          end

          def is_a_thousand?
            @current_capacity.odd?
          end

          def megs
            super({:number => @figures.number_in_capacity(@current_capacity)})
          end
        end
      end
    end
  end
end
