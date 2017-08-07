module NumbersAndWords
  module Strategies
    module ArrayJoiner
      module Languages
        module Families
          module Base
            def elements_logic
              @elements.first.empty? ? @elements.last : @elements.join(union_element)
            end

            def union_element
              union_separator.empty? ? ' ' : " #{union_separator} "
            end

            def union_separator
              options[:union_separator] || @translations.union_separator || ''
            end
          end
        end
      end
    end
  end
end
