module NumbersAndWords
  module Strategies
    class Nl < Base
      include Families::Latin
      include NumbersAndWords::TranslationsHelpers::Nl

      def hundreds_number_to_words
        [super.reverse.join]
      end

      def capacity_iteration capacity
        if FiguresArray::THOUSAND_CAPACITY == capacity
          words = []
          capacity_words = words_in_capacity(capacity)
          words.push(translation_megs(capacity)) unless capacity_words.empty?
          capacity_words.empty? ? [] : [capacity_words, words].join
        else
          super
        end
      end
    end
  end
end
