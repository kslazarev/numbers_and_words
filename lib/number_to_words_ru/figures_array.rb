class FiguresArray < Array
  include ArrayAdditions::Translations
  include ArrayAdditions::Helpers
  include ArrayAdditions::ConversionLogic
  include ArrayAdditions::Validations

  def to_words
    validate_figure_array!
    !reverse.strings.empty? ? reverse.strings.reverse.join(' ') : zero
  end
end
