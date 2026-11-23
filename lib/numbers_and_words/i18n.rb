# frozen_string_literal: true

require 'concurrent/map'
require 'numbers_and_words/i18n/pluralization'
require 'numbers_and_words/i18n/initialization'
require 'numbers_and_words/i18n/extends'
require 'numbers_and_words/i18n/invalidation'

module NumbersAndWords
  # Raised when the current locale has no bundled rules, or its bundled locale is not enabled by the configuration.
  # A RuntimeError, as 1.0 raised, so rescue RuntimeError still catches it.
  class UnsupportedLanguageError < RuntimeError; end

  module I18n
    module_function

    # Class names by locale or language, which don't change at runtime.
    LANGUAGE_CLASS_NAMES = Concurrent::Map.new
    CLASS_NAMES = Concurrent::Map.new
    MISSING = Object.new.freeze

    def languages
      @languages ||= locale_files.map { |path| language_of(path) }
    end

    # ::I18n.t, kept until translations change; a translation with a count is looked up each time.
    def t(key, **options)
      return ::I18n.t(key, **options) if options.key?(:count)

      cached(:translations, [::I18n.locale, key, options]) { ::I18n.t(key, **options) }
    end

    # The value the block derives from translations, kept under the key in the named cache of I18n's Simple backend
    # until it stores or reloads translations. With another backend, which may change translations without telling,
    # the block runs each time.
    def cached(name, key, &)
      backend = ::I18n.backend
      return yield unless backend.is_a?(Invalidation)

      cache = backend.numbers_and_words_cache(name)
      value = cache.fetch(key, MISSING)
      value.equal?(MISSING) ? cache.compute_if_absent(key, &) : value
    end

    # What separates the words of a number in the language: a space, or nothing in languages written without spaces,
    # under numbers.word_separator.
    def word_separator(language = local_language)
      t('numbers.word_separator', locale: language, default: ' ')
    end

    # The class name of a language's classes, or of a shared reading: :'pt-BR' is PtBr, :counted_fraction CountedFraction.
    def class_name(language)
      CLASS_NAMES[language] || CLASS_NAMES.compute_if_absent(language) { language.to_s.split(/[-_]/).map(&:capitalize).join.freeze }
    end

    # Defines the class the block makes in the namespace for each bundled language without one of its own, under
    # the language's class name, such as Translations::Sv; a language that extends another, such as British
    # English, gets a subclass of the other's class.
    def define_classes(namespace)
      languages.sort_by { |language| parents.key?(language) ? 1 : 0 }.each do |language|
        name = class_name(language)
        namespace.const_set(name, parent_class(namespace, language) || yield) unless namespace.const_defined?(name, false)
      end
    end

    def parent_class(namespace, language)
      parent = parents[language] && class_name(parents[language])
      Class.new(namespace.const_get(parent, false)) if parent && namespace.const_defined?(parent, false)
    end

    # The language each bundled language that extends another extends: :'en-GB' => :en.
    def parents
      @parents ||= locale_files.to_h { |file| [language_of(file), Extends.parent(file)] }.compact
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
      configured = NumbersAndWords.config.locales
      return language if configured.nil? || configured.include?(language)

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

    def language_class_name(locale = ::I18n.locale)
      LANGUAGE_CLASS_NAMES[locale] || LANGUAGE_CLASS_NAMES.compute_if_absent(locale) { locale.to_s.split('-').collect(&:capitalize).join.freeze }
    end

    def locale_files
      files 'locales', '*.*'
    end

    def files(directory, ext)
      Dir[File.join File.dirname(__FILE__), "i18n/#{directory}", "**/#{ext}"]
    end
  end
end
