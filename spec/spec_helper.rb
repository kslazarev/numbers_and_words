# frozen_string_literal: true

$LOAD_PATH.unshift File.join(File.dirname(__FILE__), '..', 'lib')

require 'simplecov'
require 'simplecov-lcov'

SimpleCov::Formatter::LcovFormatter.config do |config|
  config.report_with_single_file = true
  config.single_report_path = 'coverage/lcov.info'
end
SimpleCov.formatters = [SimpleCov::Formatter::HTMLFormatter, SimpleCov::Formatter::LcovFormatter]
SimpleCov.start

require 'numbers_and_words'
require 'support/helpers'
