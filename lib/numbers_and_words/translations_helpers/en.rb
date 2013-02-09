module NumbersAndWords
  module TranslationsHelpers
    module En
      include NumbersAndWords::TranslationsHelpers::Base
      include NumbersAndWords::TranslationsHelpers::Families::Latin
      include NumbersAndWords::TranslationsHelpers::Extensions::FractionSignificance

      def translation_tens_with_ones numbers
        super numbers, options[:remove_hyphen] ? ' ' : '-'
      end

      def translation_hundreds number
        hundreds = [t(:ones)[number], t(:hundreds)]
        hundreds << t(:union) if options[:hundreds_with_union]
        hundreds.join ' '
      end
    end
  end
end
