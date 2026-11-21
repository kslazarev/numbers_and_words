# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        class De < Base
          # remove_zero: true omits a zero integral part.
          def zero(*args)
            super unless @options.remove_zero.result
          end

          # Ordinals take the -te (1-19) or -ste (20 and above) suffix on the
          # final element and are written as one word, e.g. "zweimillionste".
          ORDINAL_REPLACEMENTS = { 'eins' => 'erste', 'drei' => 'dritte', 'sieben' => 'siebte', 'acht' => 'achte' }.freeze
          ORDINAL_STE_ENDINGS = %w[zig ßig hundert tausend].freeze

          def words
            result = super
            @options.ordinal&.result ? ordinal(result) : result
          end

          def print_words
            complex_part.count > 1 ? print_megs_words : @strings.flatten.reverse.join
          end

          def print_megs_words
            [print_megs, print_other].reject(&:empty?).join(' ')
          end

          def complex_number_to_words
            (1..@figures.capacity_count).map do |capacity|
              @current_capacity = capacity
              capacity_iteration
            end
          end

          def ones
            super(postfix:)
          end

          def postfix
            case (@current_capacity ||= 0)
            when 1 then :combine
            when 0 then :default
            else :gender
            end
          end

          def megs
            super({ number: @figures.number_in_capacity(@current_capacity) })
          end

          private

          def ordinal(cardinal)
            words = cardinal.split
            last = words.pop
            return [*words, ordinal_word(last)].join.downcase unless last.match?(/\A[[:upper:]]/)

            count = words.pop.delete_suffix('e')
            count = '' if count == 'ein' && words.empty?
            [*words, "#{count}#{meg_stem(last)}ste"].join.downcase
          end

          def ordinal_word(word)
            ORDINAL_REPLACEMENTS.each do |ending, replacement|
              return "#{word.delete_suffix(ending)}#{replacement}" if word.end_with?(ending)
            end
            word.end_with?(*ORDINAL_STE_ENDINGS) ? "#{word}ste" : "#{word}te"
          end

          def meg_stem(word)
            word = word.downcase
            word.end_with?('ionen') ? word.delete_suffix('en') : word.sub(/en?\z/, '')
          end

          def print_megs
            complex_part[1..].reject(&:empty?).map do |el|
              [el[1..].reverse.join, el.first].join(' ')
            end.reverse.join(' ')
          end

          def print_other
            [print_thousands, simple_part.reverse.join].join
          end

          def print_thousands
            complex_part.first.reverse.join
          end

          def simple_part
            @strings.grep_v(Array)
          end

          def complex_part
            @strings - simple_part
          end
        end
      end
    end
  end
end
