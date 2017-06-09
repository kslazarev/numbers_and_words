module NumbersAndWords
  module I18n
    module Initialization
      extend self

      def init
        I18n.locale_files.each { |locale_file| ::I18n.load_path << locale_file if app_locale?(locale_file) }
        NumbersAndWords::I18n::Pluralization.init
        ::I18n.backend.reload!
      end

      private

      def app_locale?(file)
        return true unless app_locales

        locale = file.split('.')[-2].to_sym
        app_locales.include?(locale)
      end

      def app_locales
        @app_locales ||= (I18n::APP_LOCALES if I18n.const_defined?(:APP_LOCALES))
      end
    end
  end
end
