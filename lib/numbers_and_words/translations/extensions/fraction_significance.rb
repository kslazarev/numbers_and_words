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

        def micro(capacity)
          t(:micro)[capacity]
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
