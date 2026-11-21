# frozen_string_literal: true

require 'numbers_and_words/wrappers/integer'
require 'numbers_and_words/wrappers/float'

module NumbersAndWords
  module Wrappers
    # The wrapper that converts an element without validating options again.
    def self.for(element)
      case element
      when ::Integer then Integer.new(element)
      when ::Float then Float.new(element)
      else element
      end
    end
  end
end
