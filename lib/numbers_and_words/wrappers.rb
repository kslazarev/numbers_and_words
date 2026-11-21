# frozen_string_literal: true

require 'numbers_and_words/wrappers/sign'
require 'numbers_and_words/wrappers/integer'
require 'numbers_and_words/wrappers/float'

module NumbersAndWords
  # Raised when to_words receives a number the current language cannot convert, such as a decimal in a
  # language without decimals or the ordinal of a negative number.
  class UnsupportedNumberError < ArgumentError; end

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
