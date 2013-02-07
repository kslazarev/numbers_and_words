module NumbersAndWords
  module Strategies
    module Families
      module Cyrillic
        include NumbersAndWords::Strategies::Families::Base

        attr_accessor :current_capacity

        private

        def words_in_capacity capacity = 0
          @current_capacity = capacity
          super
        end

        def gender
          case current_capacity.to_i
          when 1
            :female
          when 0
            options[:gender] || :male
          else
            :male
          end
        end
      end
    end
  end
end
