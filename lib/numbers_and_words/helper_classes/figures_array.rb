require 'numbers_and_words/helper_classes/array_extensions/helpers'
require 'numbers_and_words/helper_classes/array_extensions/validations'

module NumbersAndWords
  class FiguresArray < Array
    include ArrayExtensions::Helpers
    include ArrayExtensions::Validations

    def to_words options = {}
      validate_figure_array!
      Strategies.figures_converter.new(self, options).run
    end

    def reverse
      super.to_figures
    end
  end
end
