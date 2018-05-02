# frozen_string_literal: true

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
              micro_separator.empty? ? ' ' : " #{micro_separator} "
            end

            def micro_separator
              options[:micro_separator] || @translations.micro_separator || ''
            end
          end
        end
      end
    end
  end
end
