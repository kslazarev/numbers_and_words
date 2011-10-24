$TESTING=true
$:.unshift File.join(File.dirname(__FILE__), '..', 'lib')

require 'number_to_words_ru'

RSpec.configure do
  include TranslationsHelpers::Base
end
