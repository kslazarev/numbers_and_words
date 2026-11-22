# frozen_string_literal: true

module NumbersAndWords
  module Translations
    module Families
      module Base
        # The RangeError for a number of 10**power or more in the current locale.
        def self.range_error(power)
          RangeError.new("numbers must be below 10**#{power} in #{::I18n.locale.inspect}")
        end

        # The RangeError for a decimal with more fractional digits than the current locale can name.
        def self.decimal_range_error(digits)
          RangeError.new("decimals support up to #{digits} fractional digits in #{::I18n.locale.inspect}")
        end

        # The scale word or key for 1000**capacity, or a RangeError past the last one the locale has.

        def micro_separator
          t :micro_separator
        end
      end
    end
  end
end
