module NumbersAndWords
  module Translations
    class Cs < Base
      include NumbersAndWords::Translations::Families::Base
      include NumbersAndWords::Translations::Extensions::FractionSignificance

      def zero(options = {})
        ones(0, options)
      end

      def ones(number, options = {})
        t([options[:prefix], :ones, options[:gender]].join('.'))[number]
      end

      # for 20, 30, 60
      def tens(number, options = {})
        t([options[:prefix], :tens, gender_to_use(options)].join('.'))[number]
      end

      # for 12, 13, 19
      def teens(number_arr, options = {})
        t([options[:prefix], :teens, gender_to_use(options)].join('.'))[number_arr.first]
      end

      # for 42, 23, 69
      def tens_with_ones(numbers_arr, options = {})
        connector = ' '
        [tens(numbers_arr[1], options), connector, ones(numbers_arr[0], options)].join
      end

      def hundreds(number, options = {})
        t([options[:prefix], :hundreds, gender_to_use(options)].join('.'))[number]
      end

      def thousands(number, options = {})
        t([options[:prefix], :thousands, gender_to_use(options)].join('.'))[number]
      end

      def megs(capacity, options = {})
        number = options[:number]
        mega_name = "#{options[:prefix]}.mega"
        number ? t(mega(capacity), count: number) : t(mega_name)[capacity]
      end

      def mega(capacity)
        t(:mega)[capacity]
      end

      def integral(number, _options = {})
        t(:integral, count: number)
      end

      def micros(capacity, number = nil, separator = '')
        micro, prefix = capacity
        micros = t(:micro, count: number)[micro]
        [micro_prefix(prefix), micros].compact.join separator
      end

      def micro_prefix(capacity)
        case capacity
        when 2 then t(:sub_micro)[2]
        when 1 then t(:sub_micro)[1]
        end
      end

      private

      def ordinal?(options)
        options[:prefix] == :ordinal
      end

      def gender_to_use(options)
        ordinal?(options) ? options[:gender] : nil
      end
    end
  end
end
