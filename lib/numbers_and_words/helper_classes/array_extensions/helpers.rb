module NumbersAndWords
  module ArrayExtensions
    module Helpers
      MICRO_CAPACITY_SHIFT = 2
      FIGURES_IN_CAPACITY = 3
      THOUSAND_CAPACITY = 1
      ONES_SHIFT = 1

      def capacity_length
        length - ONES_SHIFT
      end

      def capacity_count
        count = capacity_length / FIGURES_IN_CAPACITY
        0 == count ? nil : count
      end

      def figures_array_in_capacity capacity
        self[capacity * FIGURES_IN_CAPACITY, FIGURES_IN_CAPACITY]
      end

      def number_in_capacity capacity
        figures_array_in_capacity(capacity).reverse.join.to_i
      end

      def ones
        self[0].to_i if 0 < self[0].to_i
      end

      def teens
        tens_with_ones if 1 == tens
      end

      def tens
        self[1].to_i if self[1] && 0 < self[1].to_i
      end

      def tens_with_ones
        [ones, tens] if ones && tens
      end

      def hundreds
        self[2].to_i if 0 < self[2].to_i
      end

      def round_hundred?
        ones.nil? && tens.nil?
      end

      def sub_capacity
        capacity_length % FIGURES_IN_CAPACITY
      end

      def fraction_capacity
        [fraction_capacity_count, fraction_sub_capacity]
      end

      def fraction_capacity_count
        capacity_count.nil? ? sub_capacity : capacity_count + MICRO_CAPACITY_SHIFT
      end

      def fraction_sub_capacity
        sub_capacity unless capacity_count.nil?
      end

      def ordinal_index
        index { |figure| figure != 0 }
      end

      def ordinal_capacity
        count = ordinal_index / FIGURES_IN_CAPACITY
        0 == count ? nil : count
      end
    end
  end
end

