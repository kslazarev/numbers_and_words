# frozen_string_literal: true

module NumbersAndWords
  module Translations
    module Extensions
      module FractionSignificance
        def micros(capacity, number = nil)
          micro, prefix = capacity
          micros = number ? t(micro(micro), count: number) : micro(micro)
          [micro_prefix(prefix), micros].compact.join(t('micro_prefix.union'))
        end

        # The fraction word key for a capacity, or a RangeError past the last one the locale has: a bare prefix
        # ("сто") would lose the denominator.
        def micro(capacity)
          micros = t(:micro)
          micros[capacity] || raise(Families::Base.decimal_range_error(fraction_digits(micros)))
        end

        # The last fraction word with a hundreds prefix: tenths and hundredths, then thousandths and every power of
        # a thousand after them.
        def fraction_digits(micros)
          (3 * (micros.size - 1 - ArrayExtensions::Helpers::MICRO_CAPACITY_SHIFT)) + 2
        end

        def micro_prefix(capacity)
          case capacity
          when 2 then t('micro_prefix.hundreds')
          when 1 then t('micro_prefix.tens')
          end
        end
      end
    end
  end
end
