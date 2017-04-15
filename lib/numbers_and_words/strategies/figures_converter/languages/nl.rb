module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        class Nl < Base
          include Families::Latin

          def hundreds_number_to_words
            [super.reverse.join]
          end

          def capacity_iteration
            if FiguresArray::THOUSAND_CAPACITY == @current_capacity
              words = []
              capacity_words = words_in_capacity(@current_capacity)
              words.push megs unless capacity_words.empty?
              capacity_words.empty? ? [] : [capacity_words, words].join
            else
              super
            end
          end

          [:zero, :ones, :teens, :tens, :tens_with_ones, :hundreds, :megs].each do |method_name|
            define_method(method_name) {
              super({:prefix => maybe_ordinal(method_name)})
            }
          end

          def maybe_ordinal type
            @options.ordinal.result type
          end
        end
      end
    end
  end
end
