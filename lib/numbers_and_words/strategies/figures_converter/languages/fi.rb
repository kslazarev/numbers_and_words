# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        # Finnish writes numbers below a million as one word ("kaksituhattakolmesataakaksikymmentäyksi") and
        # millions and larger as separate words ("kaksi miljoonaa"). Scale words take the partitive after
        # numbers above one ("kaksituhatta", "kaksi miljoonaa"); a lone one is omitted ("tuhat", "miljoona").
        # Ordinals make every part ordinal ("kahdeskymmenesensimmäinen", "kahdestuhannes").
        class Fi < Base
          MAX = 10**15

          def words
            number = @figures.to_a.reverse.join.to_i
            raise Translations::Families::Base.range_error(Math.log10(MAX).to_i) if number >= MAX
            return zero_words if number.zero?

            number_words(number)
          end

          private

          def zero_words
            return t(:ordinals)[:ones][0] if ordinal?

            @options.remove_zero.result ? '' : t(:ones)[0]
          end

          # Millions and larger are separate words; thousands and the last group form one word.
          def number_words(number)
            large, small = groups(number).partition { |_group, capacity| capacity >= 2 }
            words = large.map { |group, capacity| scale_words(group, capacity) }
            words << small.map { |group, capacity| small_words(group, capacity) }.join
            words.reject(&:empty?).join(' ')
          end

          # The nonzero groups of three digits with their capacity, from the largest down.
          def groups(number)
            number.digits(1000).each_with_index.reject { |group, _capacity| group.zero? }.reverse
          end

          def small_words(group, capacity)
            capacity.zero? ? group_words(group, final: true) : scale_words(group, capacity)
          end

          def scale_word(group, capacity)
            return t(:ordinals)[:mega][capacity] if ordinal?

            t(group == 1 ? :mega : :megas)[capacity]
          end

          def scale_words(group, capacity)
            scale = scale_word(group, capacity)
            return scale if group == 1

            [group_words(group, final: false), scale].join(capacity == 1 ? '' : ' ')
          end

          def group_words(group, final:)
            hundreds, rest = group.divmod(100)
            [(hundreds_words(hundreds) unless hundreds.zero?), (rest_words(rest, final) unless rest.zero?)].join
          end

          def hundreds_words(hundreds)
            if ordinal?
              "#{multiplier(hundreds) unless hundreds == 1}#{t(:ordinals)[:hundred]}"
            else
              hundreds == 1 ? t(:hundred) : "#{t(:ones)[hundreds]}#{t(:hundreds)}"
            end
          end

          def rest_words(rest, final)
            return ones_words(rest, final) if rest < 10
            return ordinal? ? t(:ordinals)[:ten] : t(:ten) if rest == 10
            return "#{prefix(rest - 10)}#{t(:teens)}" if rest < 20

            tens, ones = rest.divmod(10)
            "#{tens_words(tens)}#{ones_words(ones, final) unless ones.zero?}"
          end

          def tens_words(tens)
            "#{prefix(tens)}#{ordinal? ? t(:ordinals)[:tens] : t(:tens)}"
          end

          # A digit before toista or kymmentä: "kaksi" in cardinals, "kahdes" in ordinals.
          def prefix(digit)
            ordinal? ? multiplier(digit) : t(:ones)[digit]
          end

          # The last ones of an ordinal are "ensimmäinen" and "toinen"; inside it, 1 and 2 are "yhdes" and "kahdes".
          def ones_words(ones, final)
            return t(:ones)[ones] unless ordinal?

            final ? t(:ordinals)[:ones][ones] : multiplier(ones)
          end

          def multiplier(digit)
            t(:ordinals)[:multipliers][digit]
          end

          def ordinal?
            @options.ordinal.result && @options.options[:integral].nil? && @options.options[:fractional].nil?
          end

          def t(key)
            @translations.t(key)
          end
        end
      end
    end
  end
end
