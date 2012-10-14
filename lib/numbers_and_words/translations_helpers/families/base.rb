module NumbersAndWords
  module TranslationsHelpers
    module Families
      module Base

        private

        def translation_teens number
          t(:teens)[number]
        end

        def translation_tens number
          t(:tens)[number]
        end
      end
    end
  end
end