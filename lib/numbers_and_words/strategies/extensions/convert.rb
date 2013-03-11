module NumbersAndWords
  module Strategies
    module Extensions
      module Convert

        attr_accessor :figures, :options, :words

        def convert figures, options = {}
          @options = options
          @figures = figures.reverse
          around_convert {
            @words = strings
            words.empty? && zero || print_format
          }
        end

        private

        def print_words
          words.reverse.join ' '
        end

        def print_format
          print_words
        end

        def around_convert
          before_convert
          result = yield
          after_convert
          result
        end

        def before_convert
        end

        def after_convert
        end
      end
    end
  end
end
