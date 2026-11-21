# frozen_string_literal: true

module NumbersAndWords
  module Translations
    module Families
      module Cyrillic
        include NumbersAndWords::Translations::Families::Base

        def integral(number, _options = {})
          t(:integral, count: number)
        end
      end
    end
  end
end
