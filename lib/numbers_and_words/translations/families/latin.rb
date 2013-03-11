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
      end
    end
  end
end
