# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        # Indonesian counts in groups of three digits. One ten, hundred or thousand takes the prefix se-
        # (sepuluh, sebelas, seratus, seribu), but larger scales keep satu (satu juta). Teens are "<digit> belas",
        # tens "<digit> puluh" and hundreds "<digit> ratus". Ordinals add the prefix ke- (kedua puluh satu),
        # except pertama for 1. Malay uses the same rules with its own words.
        class Id < Base
          LANGUAGE = 'Indonesian'
          MAX = 10**15

          def words
            number = @figures.to_a.reverse.join.to_i
            raise RangeError, "#{self.class::LANGUAGE} numbers must be below 10**15" if number >= MAX
            return zero_words if number.zero?

            text = number_words(number)
            ordinal? ? ordinal_words(number, text) : text
          end

          private

          def zero_words
            @options.remove_zero.result ? '' : @translations.zero
          end

          # Decimals, and either part of one, keep the cardinal form.
          def ordinal?
            @options.ordinal.result && @options.options[:integral].nil? && @options.options[:fractional].nil?
          end

          def ordinal_words(number, text)
            number == 1 ? t(:ordinals)[:first] : "#{t(:ordinals)[:prefix]}#{text}"
          end

          def number_words(number)
            number.digits(1000).each_with_index.reject { |group, _capacity| group.zero? }.reverse.map do |group, capacity|
              capacity.zero? ? group_words(group) : scale_words(group, capacity)
            end.join(' ')
          end

          # seribu for one thousand, satu juta for one million.
          def scale_words(group, capacity)
            return "#{t(:one_prefix)}#{@translations.mega(capacity)}" if group == 1 && capacity == 1

            "#{group_words(group)} #{@translations.mega(capacity)}"
          end

          def group_words(group)
            hundreds, rest = group.divmod(100)
            [(multiple(hundreds, :hundreds) unless hundreds.zero?), rest_words(rest)].compact.join(' ')
          end

          def rest_words(rest)
            return if rest.zero?
            return @translations.ones(rest) if rest < 10
            return t(:ten) if rest == 10
            return t(:eleven) if rest == 11
            return "#{@translations.ones(rest - 10)} #{t(:teen)}" if rest < 20

            tens, ones = rest.divmod(10)
            [multiple(tens, :tens), (@translations.ones(ones) unless ones.zero?)].compact.join(' ')
          end

          # seratus for one hundred, dua ratus for two.
          def multiple(digit, key)
            digit == 1 ? "#{t(:one_prefix)}#{t(key)}" : "#{@translations.ones(digit)} #{t(key)}"
          end

          def t(key)
            @translations.t(key)
          end
        end
      end
    end
  end
end
