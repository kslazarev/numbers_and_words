# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        module Families
          # The Indian numbering system shared by Hindi, Bengali and Urdu. Every number from 0 to 99 is its own word,
          # the last three digits are read as hundreds, and each scale above them groups two digits: thousand (10^3),
          # lakh (10^5), crore (10^7) and, where the language has them, more (Hindi and Urdu arab 10^9 and kharab 10^11).
          # The largest scale repeats for larger numbers, its count spelled the same way, so 10^10 in Bengali is
          # "এক হাজার কোটি". Words are separated by spaces.
          #
          # A language includes this module and reads its words from a locale file with ones (100 words), hundreds
          # (10, index 0 unused), scales (from thousand up), ordinals and micro_separator.
          module Indian
            def words
              number = @figures.to_a.reverse.join.to_i
              return ordinal_words(number) if ordinal?
              return zero_words if number.zero?

              number_words(number)
            end

            private

            def number_words(number)
              scales = @translations.scales
              high, rest = number.divmod(scale_power(scales.size - 1))
              words = high.positive? ? ["#{number_words(high)} #{scales.last}"] : []
              words.concat(scale_words(rest, scales))
              words << hundreds_words(rest % 1000) if (rest % 1000).positive?
              words.join(' ')
            end

            # Each scale below the largest counts from 1 to 99: "तेईस लाख", "पैंतालीस हज़ार".
            def scale_words(number, scales)
              (scales.size - 2).downto(0).filter_map do |index|
                count = number / scale_power(index) % 100
                "#{@translations.ones(count)} #{scales[index]}" if count.positive?
              end
            end

            # 10^3 for the first scale word, then every two digits: 10^5, 10^7, 10^9, 10^11.
            def scale_power(index)
              10**(3 + (2 * index))
            end

            def hundreds_words(number)
              hundreds, rest = number.divmod(100)
              [(@translations.hundreds(hundreds) if hundreds.positive?), (@translations.ones(rest) if rest.positive?)].compact.join(' ')
            end

            # A few small ordinals are their own words; the rest add a suffix to the last word of the cardinal.
            def ordinal_words(number)
              forms = ordinal_forms
              forms[:irregular][number] || "#{number.zero? ? @translations.ones(0) : number_words(number)}#{forms[:suffix]}"
            end

            # Decimals, and either part of one, keep the cardinal form.
            def ordinal?
              @options.ordinal.result && @options.options[:integral].nil? && @options.options[:fractional].nil?
            end

            # remove_zero: true omits a zero integral part; the fractional part is read by its decorator.
            def zero_words
              @options.remove_zero.result ? '' : @translations.ones(0)
            end
          end
        end
      end
    end
  end
end
