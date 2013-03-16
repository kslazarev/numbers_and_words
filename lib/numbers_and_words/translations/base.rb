module NumbersAndWords
  module Translations
    class Base
      I18N_NAMESPACE = :numbers

      def t attribute, options = {}
        ::I18n.t attribute, options.merge(:scope => I18N_NAMESPACE)
      end
    end
  end
end
