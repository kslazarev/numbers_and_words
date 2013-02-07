module NumbersAndWords
  module TranslationsHelpers
    module En
      include NumbersAndWords::TranslationsHelpers::Base
      include NumbersAndWords::TranslationsHelpers::Families::Latin

      def translation_tens_with_ones numbers
        super numbers, options[:remove_hyphen] ? ' ' : '-'
      end
    end
  end
end
