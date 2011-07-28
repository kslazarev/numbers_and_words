require 'rubygems'
require 'i18n'
require 'pluralization'
require 'number_to_words_ru/integer'

module NumberToWordsRu
  extend self

  def init_i18n
    I18n.locale = :ru
    I18n.load_path.unshift(*locale_files)
  end

  def locale_files
    Dir[File.join(File.dirname(__FILE__), "locales", "**/*")]
  end
end

NumberToWordsRu.init_i18n
