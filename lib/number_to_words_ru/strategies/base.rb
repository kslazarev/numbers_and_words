module Strategies
  class Base
    attr_accessor :figures, :words

    def self.factory
      "Strategies::#{I18n.locale.to_s.titleize}".constantize.new
    end
  end
end

