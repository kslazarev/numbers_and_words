module NumbersAndWords
  class FiguresArray < Array
    include NumbersAndWords::ArrayAdditions::Helpers
    include NumbersAndWords::ArrayAdditions::Validations

    def to_words strategy, options = {}
      validate_figure_array!
      strategy.convert self, options
    end

    def integer_part
      fractional_index && self[0..fractional_index - 1].to_figures || self
    end

    def fractional_part
      (fractional_index && self[fractional_index + 1..-1] || []).to_figures
    end

    def reverse
      super.to_figures
    end
  end
end
