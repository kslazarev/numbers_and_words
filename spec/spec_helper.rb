$TESTING=true
$:.unshift File.join(File.dirname(__FILE__), '..', 'lib')

require 'numbers_and_words'

RSpec.configure { include NumbersAndWords::TranslationsHelpers::Base }
