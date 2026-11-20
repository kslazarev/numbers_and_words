# frozen_string_literal: true

module NumbersAndWords
  module I18n
    module Initialization
      module_function

      # The gem writes I18n.load_path in two places: init appends its files at
      # require time, before translations are loaded, and load_locales assigns it
      # on configure, which makes I18n reload so that removed locales are dropped.
      def init
        files = [Pluralization::CONFIG_FILE] + locale_files(NumbersAndWords.config.locales)
        ::I18n.load_path.concat(files - ::I18n.load_path)
        Pluralization.init
      end

      def load_locales(locales)
        ::I18n.load_path = (::I18n.load_path - I18n.locale_files) + locale_files(locales)
      end

      # The gem's locale files for the given languages, or all of them for nil.
      def locale_files(locales)
        files = I18n.locale_files
        locales.nil? ? files : files.select { |file| locales.include?(I18n.language_of(file)) }
      end
    end
  end
end
