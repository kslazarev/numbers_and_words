module NumbersAndWords
  module Strategies
    class Base
      include Extensions::Convert
      include Extensions::Union

      def self.factory
        "NumbersAndWords::Strategies::#{::I18n.locale.to_s.titleize}".constantize.new
      end

      def support_fractional_options?
        support? Extensions::Options::Fractional
      end

      def support? checking_module
        self.class.ancestors.include? checking_module
      end
    end
  end
end
