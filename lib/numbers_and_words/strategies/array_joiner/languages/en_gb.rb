module NumbersAndWords
  module Strategies
    module ArrayJoiner
      module Languages
        class EnGb < Base
          def elements_logic
            @elements.join union_element
          end

          def union_element
            @elements.first.blank? ? "#{union_separator} " : super
          end
        end
      end
    end
  end
end
