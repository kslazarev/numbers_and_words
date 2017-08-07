module NumbersAndWords
  module Translations
    class Es < Base
      include NumbersAndWords::Translations::Families::Latin
      include NumbersAndWords::Translations::Extensions::FractionSignificance

      def zero(_options = {})
        t(%i[ones male].join('.'))[0]
      end

      def ones(number, options = {})
        return if options[:is_one_thousand]
        return t(%i[ones apocopated].join('.')) if number == 1 &&
                                                   options[:is_apocopated]
        t([:ones, options[:gender]].join('.'))[number]
      end

      def twenties_with_ones(numbers, options = {})
        return t(%i[twenties apocopated].join('.')) if options[:is_apocopated]
        t([:twenties, options[:gender]].join('.'))[numbers[0]]
      end

      def tens_with_ones(numbers, options = {})
        [tens(numbers[1], alone: false),
         t(:union),
         ones(numbers[0], options)].join(' ')
      end

      def hundreds(number, options = {})
        return t(%i[hundreds apocopated].join('.')) if options[:is_apocopated]
        t([:hundreds, options[:gender]].join('.'))[number]
      end

      def micros(capacity, number = nil)
        micro, prefix = capacity
        micros = number ? t(micro(micro), count: number) : micro(micro)
        [micro_prefix(prefix), micros].compact.join
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
