# frozen_string_literal: true

module NumbersAndWords
  module Translations
    class PtBr < Base
      include NumbersAndWords::Translations::Families::Base
      include NumbersAndWords::Translations::Extensions::FractionSignificance

      def integral(number, _options = {})
        t(:integral, count: number)
      end

      def zero(options = {})
        t([options[:prefix], :ones, :male].join('.'))[0]
      end

      def ones(number, options = {})
        return if options[:is_one_thousand]

        t([options[:prefix], :ones, options[:gender]].join('.'))[number]
      end

      def tens(number, options = {})
        path = [options[:prefix], :tens]
        path.push(options[:gender]) if ordinal?(options)
        t(path.join('.'))[number]
      end

      def teens(number, options = {})
        return [tens(1, options), ones(number[0], options)].join(' ') if ordinal? options

        super(number, options)
      end

      def tens_with_ones(numbers, options = {})
        connector = ordinal?(options) ? ' ' : " #{union} "
        [tens(numbers[1], options), ones(numbers[0], options)].join(connector)
      end

      def hundreds(number, options = {})
        return t(:one_hundred) if options[:is_one_hundred] && !ordinal?(options)

        hundreds = t([options[:prefix], :hundreds, options[:gender]].join('.'))[number]
        return hundreds if ordinal?(options) || options[:is_hundred]

        [hundreds, union].join(' ')
      end

      def megs(capacity, options = {})
        return t([options[:prefix], :mega, options[:gender]].join('.'))[capacity] if ordinal?(options)
        return super(capacity, options) if options[:is_opaque] || options[:is_without_connector]

        suffix = options[:is_with_comma] ? ',' : " #{union}"
        super(capacity, options) + suffix
      end

      def micros(capacity, number = nil)
        micro, prefix = capacity
        micros = number ? t(micro(micro), count: number) : micro(micro)
        [micro_prefix(prefix, number), micros].compact.join(t('micro_prefix.union'))
      end

      def micro_prefix(capacity, number)
        case capacity
        when 2 then t('micro_prefix.hundreds', count: number)
        when 1 then t('micro_prefix.tens', count: number)
        end
      end

      private

      def ordinal?(options)
        options[:prefix] == :ordinal
      end
    end
  end
end
