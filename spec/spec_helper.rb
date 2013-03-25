$:.unshift File.join(File.dirname(__FILE__), '..', 'lib')

require 'coveralls'
Coveralls.wear!

require 'numbers_and_words'
require 'support/helpers'
