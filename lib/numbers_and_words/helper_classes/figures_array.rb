# frozen_string_literal: true

require 'numbers_and_words/helper_classes/array_extensions/helpers'

module NumbersAndWords
  class FiguresArray < Array
    include ArrayExtensions::Helpers

    def to_words(options = {})
      local_language { Strategies.figures_converter.new(self, options).run }
    end

    def reverse
      super.to_figures
    end

    def local_language
      ::I18n.with_locale(I18n.local_language) { yield }
    end
  end
end
