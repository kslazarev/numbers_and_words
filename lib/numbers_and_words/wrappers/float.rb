module NumbersAndWords
  module Wrappers
    class Float
      attr_accessor :number

      def initialize number
        @number = number
      end

      def to_words options = {}
        words = []
        words << integral_part_with(options)
        words << fractional_part_with(options) unless fractional_part_is_nil?
        NumbersAndWords::WordsArray.new(words).join options
      end

      private

      def parts
        number.to_s.split '.'
      end

      def integral_part
        parts.first
      end

      def fractional_part
        parts.last
      end

      def integral_part_with options
        integral_part.to_i.to_words options.merge(integral_options)
      end

      def fractional_part_with options
        fractional_part.to_i.to_words options.merge(fractional_options)
      end

      def integral_options
        {:integral => {}}
      end

      def fractional_options
        {:fractional => {:length => fractional_part.length}}
      end

      def fractional_part_is_nil?
        0 == fractional_part.to_i
      end
    end
  end
end
