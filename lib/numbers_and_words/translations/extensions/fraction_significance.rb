module NumbersAndWords
  module Translations
    module Extensions
      module FractionSignificance

        def micros capacity, number = nil, separator = '-'
          micro, prefix = capacity
          micros = number ? t(micro(micro), :count => number) : micro(micro)
          [micro_prefix(prefix), micros].compact.join separator
        end

        def micro capacity
          t(:micro)[capacity]
        end

        def micro_prefix capacity
          case capacity
          when 2 then t(:hundreds)
          when 1 then tens(1)
          end
        end
      end
    end
  end
end
