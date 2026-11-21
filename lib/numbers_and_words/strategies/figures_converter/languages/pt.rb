# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        # European Portuguese uses the long scale: a scale word every million (milhão, bilião, trilião), with
        # thousands of each read as "mil" ("dois mil milhões" is 2 * 10^9).
        class Pt < Base
          prepend Ordinals

          # "e" joins the last group of three digits to the rest when it is below one hundred or a round
          # hundred ("um milhão e duzentos mil", "mil e trinta"); otherwise groups are joined without it. The same
          # rule joins the thousands of a scale word to its units ("mil e um milhões").
          def strings_logic
            return super unless @figures.capacity_count

            groups = (0..@figures.capacity_count).map { |capacity| capacity_words(capacity) }
            last = groups.index { |words| !words.empty? }
            groups.each_with_index.map do |words, capacity|
              union_before?(capacity, last, groups) ? words + [@translations.union] : words
            end.flatten
          end

          def ones
            super({ is_one_thousand: one_thousand?, gender: })
          end

          def tens_with_ones
            super({ gender: })
          end

          def hundreds
            super({ is_hundred: hundred?, is_one_hundred: one_hundred?, gender: })
          end

          def megs
            return @translations.megs(1, number: 1) if thousand_of_scale?

            super({ number: scale_count })
          end

          def zero
            super unless @options.remove_zero&.result
          end

          private

          def capacity_words(capacity)
            return number_without_capacity_to_words if capacity.zero?

            @current_capacity = capacity
            capacity_iteration.compact
          end

          def union_before?(capacity, last, groups)
            group = @figures.number_in_capacity(capacity)
            return false unless group < 100 || (group % 100).zero?
            return groups[(capacity + 1)..].any?(&:any?) if capacity == last

            capacity.even? && groups[capacity].any? && groups.fetch(capacity + 1, []).any?
          end

          # "mil", not "um mil", before every thousand ("mil milhões").
          def one_thousand?
            @current_capacity.to_i.odd? && @figures.ones == 1 && @figures.tens.nil? && @figures.hundreds.nil?
          end

          # A thousand of a scale word followed by more of it ("mil cento e setenta e quatro milhões") is "mil".
          def thousand_of_scale?
            @current_capacity.odd? && @current_capacity > 1 && !@figures.number_in_capacity(@current_capacity - 1).zero?
          end

          # The scale word is singular only for exactly one ("um milhão", "mil e um milhões").
          def scale_count
            number = @figures.number_in_capacity(@current_capacity)
            return number if @current_capacity.odd? || @current_capacity == @figures.capacity_count

            number + (1000 * @figures.number_in_capacity(@current_capacity + 1))
          end

          # gender: :female applies below a million (duzentas mil); milhão and larger scale nouns, and inteiro and
          # décimo in fractions, are masculine (dois milhões, dois inteiros e dois décimos).
          def gender
            return if @current_capacity.to_i > 1 || (@options.options[:fraction] && (@options.options[:integral] || @options.options[:fractional]))

            @options.gender.result
          end

          def hundred?
            figures[0].zero? && figures[1].zero? && simple_number_to_words.empty?
          end

          def one_hundred?
            hundred? && figures[2] == 1
          end

          # Every part of a Portuguese ordinal is ordinal ("centésimo vigésimo primeiro"), and a multiplier of a
          # scale word is ordinal too ("segundo milésimo"), as in Brazilian Portuguese. The scale words follow the
          # long scale: "milionésimo" is 10^6, "milésimo milionésimo" 10^9 and "bilionésimo" 10^12.
          def ordinal_words(text, number)
            return text if number.zero?

            words = number.digits(1_000_000).each_with_index.reverse_each.filter_map do |group, power|
              million_ordinal(group, power) unless group.zero?
            end.join(' ')
            ordinal_gender == :female ? words.gsub(/o\b/, 'a') : words
          end

          def million_ordinal(group, power)
            return thousands_ordinal(group) if power.zero?

            [(thousands_ordinal(group) unless group == 1), ordinals[:mega][power]].compact.join(' ')
          end

          def thousands_ordinal(group)
            thousands, units = group.divmod(1000)
            thousand = [(hundreds_ordinal(thousands) unless thousands == 1), ordinals[:thousand]].compact.join(' ')
            [(thousand unless thousands.zero?), (hundreds_ordinal(units) unless units.zero?)].compact.join(' ')
          end

          def hundreds_ordinal(group)
            digits = format('%03d', group).chars.map(&:to_i)
            %i[hundreds tens units].zip(digits).filter_map { |key, digit| ordinal_part(key, digit) }.join(' ')
          end
        end
      end
    end
  end
end
