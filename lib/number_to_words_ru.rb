require 'rubygems'
require 'i18n'
require 'number_to_words_ru/integer'
require 'number_to_words_ru/figure_array'

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
