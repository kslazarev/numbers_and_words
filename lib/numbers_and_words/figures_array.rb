module NumbersAndWords
  class FiguresArray < Array
    include NumbersAndWords::ArrayAdditions::Helpers
    include NumbersAndWords::ArrayAdditions::Validations

    def to_words strategy, options = {}
      validate_figure_array!
      strategy.convert casted_array, options
    end

    def integer_part
      fraction_index && self[0..fraction_index - 1].to_figures || self
    end

    def fractional_part
      (fraction_index && self[fraction_index + 1..-1] || []).to_figures
    end

    def reverse
      super.to_figures
    end

    private

    def casted_array
      map { |digit| digit == '.' && digit || digit.to_i }.to_figures
    end
  end
end
