# frozen_string_literal: true

module NumbersAndWords
  module Unit
    # A whole number directly before a unit that isn't feminine is shortened where the language does so, with its
    # apocopated option: Spanish "un euro", "veintiún euros", "primer euro", but "una peseta".
    module Apocope
      module_function

      def apply(options)
        return options if options.key?(:apocopated) || options[:gender]&.to_sym == :female
        return options unless OptionsValidation.supported_options(I18n.local_language).key?(:apocopated)

        options.merge(apocopated: true)
      end
    end
  end
end
