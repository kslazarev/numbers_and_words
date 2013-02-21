module NumbersAndWords
  module TranslationsHelpers
    module Ru
      include NumbersAndWords::TranslationsHelpers::Base
      include NumbersAndWords::TranslationsHelpers::Families::Cyrillic
      include NumbersAndWords::TranslationsHelpers::Extensions::FractionSignificance

      def translation_micros capacity, number = nil, separator = ' '
        micro, prefix = capacity
        micros = t(:micro, :count => number)[micro]
        [translation_micro_prefix(prefix), micros].compact.join separator
      end

      def translation_micro capacity

      end

      def translation_micro_prefix capacity
        case capacity
        when 2 then t(:sub_micro)[2]
        when 1 then t(:sub_micro)[1]
        end
      end

      def translation_fraction_separator options = {}
        super if options[:with_fractional_separator]
      end
    end
  end
end
