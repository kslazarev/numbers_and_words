# frozen_string_literal: true

module NumbersAndWords
  module Translations
    module Families
      # The words every language reads from its locale file the same way; a language's class can override them.
      module Base
        # The RangeError for a number of 10**power or more in the current locale.
        def self.range_error(power)
          RangeError.new("numbers must be below 10**#{power} in #{::I18n.locale.inspect}")
        end

        # The RangeError for an ordinal outside the range the current locale declares.
        def self.ordinal_range_error(minimum, maximum)
          RangeError.new("Ordinals in #{::I18n.locale.inspect} only support numbers between #{minimum} and #{maximum}.")
        end

        # The RangeError for a decimal with more fractional digits than the current locale can name.
        def self.decimal_range_error(digits)
          RangeError.new("decimals support up to #{digits} fractional digits in #{::I18n.locale.inspect}")
        end

        def micro_separator
          t :micro_separator
        end

        # The word for zero, under the prefix scope such as an ordinal's when one is given.
        def zero(options = {})
          t([options[:prefix], :ones].join('.'))[0]
        end

        def ones(number, options = {})
          t([options[:prefix], :ones].join('.'))[number]
        end

        # The word for the integral part of a decimal, such as "целых", in the plural form for the number.
        def integral(number, _options = {})
          t(:integral, count: number)
        end
      end
    end
  end
end
