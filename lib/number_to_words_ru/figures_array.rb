class FiguresArray < Array
  include ArrayAdditions::Helpers
  include ArrayAdditions::Validations

  def to_words strategy, options = nil
    validate_figure_array!
    strategy.convert self
  end
end
