module NumbersAndWords
  module TranslationsHelpers
    module Families
      module Latin
        include NumbersAndWords::TranslationsHelpers::Families::Base

        private

        def translation_ones number
          t(:ones)[number]
        end

        def translation_hundreds number, separator = ' '
          [t(:ones)[number], t(:hundreds)].join separator
        end

        def zero
          t(:ones)[0]
        end

        def translation_ordinal_ones number
          t("ordinals.ones")[number]
        end

        def translation_ordinal_hundreds number, separator = ' '
          [t(:ones)[number], t("ordinals.hundreds")].join separator
        end

        def zeroth
          t("ordinals.ones")[0]
        end
      end
    end
  end
end
