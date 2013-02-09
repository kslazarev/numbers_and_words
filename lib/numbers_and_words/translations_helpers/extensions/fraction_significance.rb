module NumbersAndWords
  module TranslationsHelpers
    module Extensions
      module FractionSignificance
        private

        def translation_micros capacity, number = nil, separator = '-'
          micro, prefix = capacity
          micros = number ? t(translation_micro(micro), :count => number) : translation_micro(micro)
          [translation_micro_prefix(prefix), micros].compact.join separator
        end

        def translation_micro capacity
          t(:micro)[capacity]
        end

        def translation_micro_prefix capacity
          case capacity
          when 2 then t(:hundreds)
          when 1 then translation_tens(1)
          end
        end
      end
    end
  end
end
