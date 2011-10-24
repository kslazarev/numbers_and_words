module ArrayAdditions
  module Helpers
    THOUSAND_CAPACITY = 1

    def capacity_count
      count = (self.length.to_f / 3).ceil
      1 == count ? nil : count
    end

    def figures_array_in_capacity capacity
      self[capacity * 3, 3]
    end

    def number_in_capacity capacity
      figures_array_in_capacity(capacity).reverse.join.to_i
    end

    def is_a_thousand_capacity? capacity
      THOUSAND_CAPACITY == capacity
    end

    def ones
      self[0] if 0 < self[0].to_i
    end

    def teens
      tens_with_ones if 1 == tens
    end

    def tens
      self[1] if self[1] and 0 < self[1].to_i
    end

    def tens_with_ones
      [ones, tens] if ones and tens
    end

    def hundreds
      self[2] if 0 < self[2].to_i
    end
  end
end
