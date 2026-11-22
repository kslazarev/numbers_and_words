# frozen_string_literal: true

require 'numbers_and_words/translations/families/base'
require 'numbers_and_words/translations/extensions/fraction_significance'

module NumbersAndWords
  module Translations
    # The words of a language. A language without a class of its own uses this one, under its name
    # (Translations::Sv).
    class Base
      include Families::Base
      include Extensions::FractionSignificance

      I18N_NAMESPACE = :numbers

      def t(attribute, options = {})
        ::I18n.t attribute, **options, scope: I18N_NAMESPACE
      end
    end
  end
end
