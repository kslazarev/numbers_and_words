$:.unshift File.join(File.dirname(__FILE__), '..', 'lib')

require 'simplecov'
require 'coveralls'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
]
SimpleCov.start

require 'numbers_and_words'
require 'support/helpers'
