# frozen_string_literal: true

require 'numbers_and_words/i18n/pluralization'
require 'numbers_and_words/i18n/initialization'

module NumbersAndWords
  # Raised when the current locale has no bundled rules, or its bundled locale is not enabled by the configuration.
  # A RuntimeError, as 1.0 raised, so rescue RuntimeError still catches it.
  class UnsupportedLanguageError < RuntimeError; end

  module I18n
    module_function

    def languages
      @languages ||= locale_files.map { |path| language_of(path) }
    end

    # The class name of a language's classes: :'pt-BR' is PtBr.
    def class_name(language)
      language.to_s.split('-').map(&:capitalize).join
    end

    # Defines the class the block makes in the namespace for each bundled language without one of its own, under
    # the language's class name, such as Translations::Sv.
    def define_classes(namespace)
      languages.each do |language|
        name = class_name(language)
        namespace.const_set(name, yield) unless namespace.const_defined?(name, false)
      end
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

    # Other codes for a bundled language: Norwegian (no) is written in Bokmål (nb).
    ALIASES = { no: :nb }.freeze

    def normalize_language(locale)
      if languages.include?(locale)
        locale
      else
        locale = locale.to_s.scan(/\w+/).first&.to_sym
        locale = ALIASES.fetch(locale) { Compatibility.locale(locale) || locale }
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
