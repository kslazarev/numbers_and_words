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

RSpec.configure do |config|
  # Specs test the conversion as 2.0 will do it: unsupported options raise, and the 1.x defaults that
  # NumbersAndWords::Compatibility applies are left out. Specs tagged :compatibility run as callers get 1.x.
  config.before do |example|
    next if example.metadata[:compatibility]

    NumbersAndWords.config.strict_options = true
    NumbersAndWords::Compatibility.apply_defaults = false
  end

  config.after do
    NumbersAndWords.config.strict_options = false
    NumbersAndWords::Compatibility.apply_defaults = true
    NumbersAndWords::Compatibility.reset!
  end
end
