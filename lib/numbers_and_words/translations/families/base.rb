# frozen_string_literal: true

module NumbersAndWords
  module Translations
    module Families
      module Base
        def teens(numbers, options = {})
          t("#{options[:prefix]}.teens")[numbers[0]]
        end

        def tens(number, options = {})
          t("#{options[:prefix]}.tens")[number]
        end

        def tens_with_ones(numbers, options = {})
          [tens(numbers[1]), ones(numbers[0], options)].join options[:separator] || ' '
        end

        def megs(capacity, options = {})
          number = options[:number]
          number ? t(mega(capacity), count: number) : scale(t("#{options[:prefix]}.mega"), capacity)
        end

        def mega(capacity)
          scale(t(:mega), capacity)
        end

        # The scale word or key for 1000**capacity, or a RangeError past the last one the locale has.
        def scale(scales, capacity)
          scales[capacity] || raise(RangeError, "numbers must be below 10**#{scales.size * 3} in #{::I18n.locale.inspect}")
        end

        def union
          t :union
        end

        def micro_separator
          t :micro_separator
        end
      end
    end
  end
end
