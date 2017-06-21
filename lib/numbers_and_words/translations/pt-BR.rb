module NumbersAndWords
  module Translations
    class PtBr < Base
      include NumbersAndWords::Translations::Families::Latin
      include NumbersAndWords::Translations::Extensions::FractionSignificance

      def integral number, options = {}
        t(:integral, :count => number)
      end

      def zero options = {}
        t([options[:prefix], :ones, :male].join('.'))[0]
      end

      def ones number, options = {}
        return if options[:is_one_thousand]
        t([options[:prefix], :ones, options[:gender]].join('.'))[number]
      end

      def tens number, options = {}
        options[:alone] = true if options[:alone].nil?
        path = [options[:prefix], :tens]
        path.push(options[:gender]) if ordinal? options
        translated = t(path.join('.'))[number]
        options[:alone] ? translated : "#{union} " + translated
      end

      def teens number, options = {}
        return [tens(1, options), ' ', ones(number[0], options)].join if ordinal? options
        super(number, options)
      end

      def tens_with_ones numbers, options = {}
        connector = ' '
        connector = " #{union} "  unless ordinal? options
        [tens(numbers[1], options), connector, ones(numbers[0], options)].join
      end

      def hundreds number, options = {}
        return t(:one_hundred) if options[:is_one_hundred] and !(ordinal? options)
        translated = t([options[:prefix], :hundreds, options[:gender]].join('.'))[number - 1]
        return translated if ordinal? options
        options[:is_hundred] ? translated : translated + " #{union}"
      end

      def megs capacity, options = {}
        return t([options[:prefix], :mega, options[:gender]].join('.'))[capacity] if ordinal? options

        options[:is_one] = false if options[:is_one].nil?
        connector = " #{union}"
        connector = ',' if options[:is_with_comma]
        suffix = options[:is_opaque] ? '' : connector
        suffix = options[:is_without_connector] ? '' : suffix
        (options[:is_one] ? t(:mega)[capacity] : t(:megas)[capacity]) + suffix
      end

      def micros capacity, number, separator = ' de '
        micro, prefix = capacity
        micros = number ? t(micro(micro), :count => number) : micro(micro)
        [micro_prefix(prefix, number), micros].compact.join separator
      end

      def micro_prefix capacity, number
        case capacity
        when 2 then t('micro_prefix.hundreds', :count => number)
        when 1 then t('micro_prefix.tens', :count => number)
        end
      end

      private

      def ordinal? options
        options[:prefix] == :ordinal
      end
    end
  end
end
