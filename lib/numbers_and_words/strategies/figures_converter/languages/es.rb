module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        class Es < Base
          include Families::Latin

          def capacity_iteration
            words = []
            capacity_words = words_in_capacity(@current_capacity)
            words.push megs(capacity_words) unless capacity_words.empty?

            if 0 < @current_capacity
              capacity_words = capacity_words.map do |word|
                if twenty_one?
                  word.gsub(@translations.ones(1), @translations.one_twenties)
                elsif !thousand? || !one?
                  word.gsub(@translations.ones(1), @translations.one)
                end
              end.compact
            end

            words + capacity_words
          end

          def hundreds
            super({ is_hundred: (figures[1, 2] == [0, 1] &&
                                 simple_number_to_words.empty?) })
          end

          def megs(capacity_words)
            super({ is_one: capacity_words == [@translations.ones(1)] })
          end

          private

          def one?
            [translations.ones(1)] == words_in_capacity(@current_capacity)
          end

          def thousand?
            @current_capacity.odd?
          end

          def twenty_one?
            figures.reverse[0..1] == [2, 1]
          end
        end
      end
    end
  end
end
