require 'rubygems'
require 'i18n'
require 'active_support/inflector'

require 'number_to_words_ru/translations_helpers'
require 'number_to_words_ru/strategies'
require 'number_to_words_ru/array_additions'
require 'number_to_words_ru/figures_array'

require 'number_to_words_ru/core_ext/integer'
require 'number_to_words_ru/core_ext/array'

module I18nInitialization
  extend self

  def init
    I18n.load_path << locale_files
  end

  def locale_files
    Dir[File.join(File.dirname(__FILE__), 'locales', '**/*')]
  end
end

I18nInitialization.init
