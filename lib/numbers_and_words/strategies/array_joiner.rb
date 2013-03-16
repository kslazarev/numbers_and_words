module NumbersAndWords
  module Strategies
    module ArrayJoiner
      class Base

        attr_accessor :options, :elements

        def initialize elements, options = {}
          @elements = elements
          @options = options
          @translations = Translations.factory
        end

        def run
          around { elements.join union_separator }
        end

        private

        def union_separator
          separator = options[:union_separator] || @translations.union || ''
          " #{separator} " if separator.present?
        end

        def around
          yield
        end
      end
    end
  end
end
