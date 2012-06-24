module NumbersAndWords
  module I18n
    module Initialization
      extend self

      def init
        locale_files.each { |locale_file| ::I18n.load_path << locale_file}
        NumbersAndWords::I18n::Pluralization.init
      end

      private

      def locale_files
        I18n.files 'locales', '*.*'
      end

      def languages
        locale_files.map{|path| path.split /[\/.]/}[-2]
      end
    end
  end
end