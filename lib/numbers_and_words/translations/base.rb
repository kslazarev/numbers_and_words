module NumbersAndWords
  module Translations
    class Base
      I18N_NAMESPACE = :numbers

      def self.factory
        "NumbersAndWords::Translations::#{::I18n.locale.to_s.titleize}".constantize.new
      end

      def t attribute, options = {}
        ::I18n.t attribute, options.merge(:scope => I18N_NAMESPACE)
      end
    end
  end
end
