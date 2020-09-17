# frozen_string_literal: true

require 'numbers_and_words/helper_classes/array_extensions/helpers'

module NumbersAndWords
  class WordsArray < Array
    def join(options = {})
      local_language { Strategies.array_joiner.new(to_a, options).run }
    end

    def local_language(&block)
      ::I18n.with_locale(I18n.local_language, &block)
    end
  end
end
