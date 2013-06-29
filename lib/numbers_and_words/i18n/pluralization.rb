require 'numbers_and_words/i18n/plurals/ru'
require 'numbers_and_words/i18n/plurals/ua'
require 'numbers_and_words/i18n/plurals/fr'
require 'numbers_and_words/i18n/plurals/es'
require 'numbers_and_words/i18n/plurals/lv'
require 'numbers_and_words/i18n/plurals/lt'

module NumbersAndWords
  module I18n
    module Pluralization
      extend self

      def init
        ::I18n.load_path << config_file
        ::I18n::Backend::Simple.send :include, ::I18n::Backend::Pluralization
      end

      def files
        I18n.files 'plurals', '*.*'
      end

      def config_file
        I18n.files('plurals', 'plurals.rb').first
      end

      def plurals_files
        files - [config_file]
      end

      def languages
        plurals_files.map{|path| path.split(/[\/.]/)[-2]}
      end
    end
  end
end
