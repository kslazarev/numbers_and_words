module ArrayAdditions
  module Helpers
    THOUSAND_CAPACITY = 1

    private

    def capacity_count
      count = (self.length.to_f / 3).ceil
      1 == count ? nil : count
    end

    def numerical_array_in_capacity capacity
      self[capacity * 3, 3]
    end

    def is_a_thousand_capacity? capacity
      THOUSAND_CAPACITY == capacity
    end

    def ones
      self[0] if 0 < self[0]
    end

    def teens
      tens_with_ones if 1 == tens
    end

    def tens
      self[1] if self[1] and 0 < self[1]
    end

    def tens_with_ones
      [ones, tens] if ones and tens
    end

    def hundreds
      0 == self[2].to_i ? nil : self[2]
    end
  end
end
