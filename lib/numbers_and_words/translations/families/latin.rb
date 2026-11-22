# frozen_string_literal: true

module NumbersAndWords
  module Translations
    module Families
      module Latin
        include NumbersAndWords::Translations::Families::Base

        def zero(options = {})
          t([options[:prefix], :ones].join('.'))[0]
        end

        def ones(number, options = {})
          t([options[:prefix], :ones].join('.'))[number]
        end
      end
    end
  end
end
