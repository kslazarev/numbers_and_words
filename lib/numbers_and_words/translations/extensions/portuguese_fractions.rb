# frozen_string_literal: true

module NumbersAndWords
  module Translations
    module Extensions
      # Fraction words shared by Portuguese variants: "quatro inteiros e cinco décimos".
      module PortugueseFractions
        include FractionSignificance

        def integral(number, _options = {})
          t(:integral, count: number)
        end

        def micros(capacity, number = nil)
          micro, prefix = capacity
          prefix_words = micro_prefix(prefix, number)
          # Only the prefix agrees in number: "décimos de milésimo", not "décimos de milésimos".
          count = prefix_words ? 1 : number
          micros = count ? t(micro(micro), count:) : micro(micro)
          [prefix_words, micros].compact.join(t('micro_prefix.union'))
        end

        def micro_prefix(capacity, number)
          case capacity
          when 2 then t('micro_prefix.hundreds', count: number)
          when 1 then t('micro_prefix.tens', count: number)
          end
        end
      end
    end
  end
end
