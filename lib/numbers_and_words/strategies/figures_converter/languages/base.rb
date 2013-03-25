module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        class Base
          include Languages::Families::Base

          attr_accessor :strategy, :figures, :translations, :strings, :options

          def initialize strategy
            @strategy = strategy
            @figures = strategy.figures
            @translations = strategy.translations
            @options = strategy.options
          end

          def words
            @strings = strings_logic
            @strings.empty? && zero || print_words
          end

          def print_words
            @strings.reverse.join ' '
          end
        end
      end
    end
  end
end
