module NumbersAndWords
  module Strategies
    module Extensions
      module Union

        def union_elements elements, options = {}
          @options = options
          around_union_elements do
            union = union_separator ? [' ',union_separator, ' '].join : ' '
            elements.join union
          end
        end

        private

        def union_separator
          options[:union_separator]
        end

        def around_union_elements
          before_union_elements
          result = yield
          after_union_elements
          result
        end

        def before_union_elements
        end

        def after_union_elements
        end
      end
    end
  end
end
