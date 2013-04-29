require 'numbers_and_words/i18n/pluralization'
require 'numbers_and_words/i18n/initialization'

module NumbersAndWords
  module I18n
    extend self

    def languages
      @languages ||= (locale_files.map { |path| path.split(/[\/.]/)[-2].to_sym })
    end

    def local_language locale = ::I18n.locale
      if languages.include?(locale)
        locale
      else
        locale = locale.to_s.scan(/\w+/).first.to_sym
        languages.include?(locale) ? locale : raise('Language not supported')
      end
    end

    def language_class_name
      ::I18n.locale.to_s.titleize.gsub ' ', ''
    end

    def locale_files
      files 'locales', '*.*'
    end

    def files directory, ext
      Dir[File.join File.dirname(__FILE__), "i18n/#{directory}", "**/#{ext}"]
    end
  end
end
