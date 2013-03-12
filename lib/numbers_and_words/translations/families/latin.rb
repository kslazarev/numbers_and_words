module NumbersAndWords
  module Translations
    module Families
      module Latin
        include NumbersAndWords::Translations::Families::Base

        #private

        def ones number
          t(:ones)[number]
        end

        def hundreds number
          [t(:ones)[number], t(:hundreds)].join ' '
        end

        def zero
          t(:ones)[0]
        end

        def ordinal_ones number
          t("ordinals.ones")[number]
        end

        def ordinal_hundreds number, separator = ' '
          [t(:ones)[number], t("ordinals.hundreds")].join separator
        end

        def zeroth
          t("ordinals.ones")[0]
        end
      end
    end
  end
end
