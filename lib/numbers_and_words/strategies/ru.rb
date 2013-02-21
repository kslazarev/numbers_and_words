module NumbersAndWords
  module Strategies
    class Ru < Base
      include Families::Cyrillic
      include Extensions::Options::Fractional
      include Extensions::Options::Integral
      include NumbersAndWords::TranslationsHelpers::Ru

      def before_convert
        options[:gender] = :female if fractional? || integral?
        super
      end

      def union_elements elements, options = {}
        elements -= [zero]
        super
      end
    end
  end
end
