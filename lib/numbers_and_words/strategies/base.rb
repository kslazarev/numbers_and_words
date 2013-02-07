module NumbersAndWords
  module Strategies
    class Base
      attr_accessor :figures, :options, :words

      def self.factory
        "NumbersAndWords::Strategies::#{::I18n.locale.to_s.titleize}".constantize.new
      end

      def convert figures, options = {}
        @figures = figures.reverse
        @options = options
        @words = strings

        @words.empty? ? zero : @words.reverse.join(' ')
      end
    end
  end
end
