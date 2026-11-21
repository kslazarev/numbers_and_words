# frozen_string_literal: true

require 'numbers_and_words/i18n/pluralization'
require 'numbers_and_words/i18n/initialization'

module NumbersAndWords
  # Raised when the current locale has no bundled rules, or its bundled locale is not enabled by the configuration.
  class UnsupportedLanguageError < StandardError; end

  module I18n
    module_function

    def languages
      @languages ||= locale_files.map { |path| language_of(path) }
    end

    # The language a bundled file belongs to: numbers.pt-BR.yml and pt-BR.rb are :'pt-BR'.
    def language_of(path)
      File.basename(path, File.extname(path)).delete_prefix('numbers.').to_sym
    end

    # The given languages that the configuration enables (all when unconfigured).
    def enabled(languages)
      configured = NumbersAndWords.config.locales
      configured.nil? ? languages : languages & configured
    end

    def local_language(locale = ::I18n.locale)
      language = normalize_language(locale)
      return language if enabled([language]).any?

      raise UnsupportedLanguageError, 'Language not configured'
    end

    def normalize_language(locale)
      if languages.include?(locale)
        locale
      else
        locale = locale.to_s.scan(/\w+/).first&.to_sym
        languages.include?(locale) ? locale : raise(UnsupportedLanguageError, 'Language not supported')
      end
    end

    def language_class_name
      ::I18n.locale.to_s.split('-').collect(&:capitalize).join
    end

    def locale_files
      files 'locales', '*.*'
    end

    def files(directory, ext)
      Dir[File.join File.dirname(__FILE__), "i18n/#{directory}", "**/#{ext}"]
    end
  end
end
