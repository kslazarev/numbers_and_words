module NumbersAndWords
  module Locales
    module Plurals

      RU = lambda do |n|
          n % 10 == 1 && n % 100 != 11 ?
            :one :
            [2, 3, 4].include?(n % 10) && ![12, 13, 14].include?(n % 100) ?
              :few :
              n % 10 == 0 || [5, 6, 7, 8, 9].include?(n % 10) || [11, 12, 13, 14].include?(n % 100) ?
                :many : :other
      end

      EN = lambda { |count| 1 == count ? :one : :other }

    end
  end
end

{
  :ru => {:i18n => {:plural => {:rule => NumbersAndWords::Locales::Plurals::RU}}},
  :en => {:i18n => {:plural => {:rule => NumbersAndWords::Locales::Plurals::EN}}}
}
