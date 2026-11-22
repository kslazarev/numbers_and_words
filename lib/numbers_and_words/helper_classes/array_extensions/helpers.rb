# frozen_string_literal: true

module NumbersAndWords
  module ArrayExtensions
    module Helpers
      MICRO_CAPACITY_SHIFT = 2
      FIGURES_IN_CAPACITY = 3
      ONES_SHIFT = 1

      def capacity_length
        length - ONES_SHIFT
      end

      def capacity_count
        count = capacity_length / FIGURES_IN_CAPACITY
        count.zero? ? nil : count
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
    end
  end
end
