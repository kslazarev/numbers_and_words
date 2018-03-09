# frozen_string_literal: true

module NumbersAndWords
  module Translations
    module Families
      module Cyrillic
        include NumbersAndWords::Translations::Families::Base

        def zero(_options = {})
          t(:ones).values.first[0]
        end

        def ones(number, options = {})
          t(:ones)[options[:gender]][number]
        end

        def hundreds(number, _options = {})
          t(:hundreds)[number]
        end

        def integral(number, _options = {})
          t(:integral, count: number)
        end
      end
    end
  end
end
