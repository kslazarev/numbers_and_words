module NumbersAndWords
  module TranslationsHelpers
    module Families
      module Latin
        include NumbersAndWords::TranslationsHelpers::Families::Base

        private

        def translation_ones number
          t(:ones)[number]
        end

        def translation_hundreds number
          [t(:ones)[number], t(:hundreds)].join ' '
        end

        def zero
          t(:ones)[0]
        end
      end
    end
  end
end