require 'rubygems'
require 'i18n'
require 'initializers/i18n'
require 'active_support/inflector'

require 'numbers_and_words/version'

require 'numbers_and_words/translations_helpers'
require 'numbers_and_words/strategies'
require 'numbers_and_words/array_additions'
require 'numbers_and_words/figures_array'

require 'numbers_and_words/core_ext/integer'
require 'numbers_and_words/core_ext/array'

module NumbersAndWords
  module I18nInitialization
    extend self

    def init
      locale_files.each { |locale_file| I18n.load_path << locale_file }
    end

    def locale_files
      Dir[File.join(File.dirname(__FILE__), 'locales', '**/*')]
    end
  end
end

NumbersAndWords::I18nInitialization.init
