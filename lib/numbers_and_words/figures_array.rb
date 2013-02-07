module NumbersAndWords
  class FiguresArray < Array
    include NumbersAndWords::ArrayAdditions::Helpers
    include NumbersAndWords::ArrayAdditions::Validations

    def to_words strategy, options = {}
      validate_figure_array!
      strategy.convert self, options
    end

    def reverse
      super.to_figures
    end
  end
end
