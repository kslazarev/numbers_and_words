# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        class It < Base
          # Compounds ending in "tre" are accented ("ventitré", "milletré"); a standalone "tre" is not.
          COMPOUND_TRE = /(?<=\p{L})tre\b/

          def print_words
            join_compound_words(@strings.reverse, compound_word_starters).join(' ').gsub(COMPOUND_TRE, 'tré')
          end

          def capacity_iteration
            words = []
            capacity_words = words_in_capacity(@current_capacity)
            words.push(megs) unless capacity_words.empty?
            return words if thousand? && one?

            # "un milione", "un miliardo": "uno" is apocopated before scale nouns
            words + (one? ? [@translations.t(:fractional_one)] : capacity_words)
          end

          def hundreds
            return super if @figures.hundreds != 1

            # For 100, don't prefix with "uno"
            return @translations.t(:hundreds) if @figures.round_hundred?

            # For 101-199, just use "cento" without number prefix
            @translations.t(:hundreds)
          end

          def hundreds_number_to_words
            # Join hundreds with simple numbers without space (e.g., "centouno" not "cento uno")
            # Return as single element array so it doesn't get re-joined with spaces
            [[hundreds, simple_number_to_words.join].join]
          end

          def megs
            super({ number: @figures.number_in_capacity(@current_capacity) })
          end

          def zero
            super unless maybe_remove_zero
          end

          private

          def join_compound_words(words, starters)
            return words if words.length < 2 || starters.empty?

            combined_words = [words.first]

            words.drop(1).each do |word|
              if joinable?(combined_words.last, word, starters)
                combined_words[-1] = "#{combined_words.last}#{word}"
              else
                combined_words << word
              end
            end

            combined_words
          end

          def compound_word_starters
            starters = [@translations.t(:thousands, count: 1)]
            starters << @translations.t(:thousands, count: 2)
            starters
          end

          # Thousands join their neighbours ("duemilacento"), but stay apart from
          # larger scale words ("un milione mille").
          def joinable?(previous, word, starters)
            return false if mega_word?(previous)

            starters.include?(word) || starter_suffix?(previous, starters)
          end

          def mega_word?(word)
            @mega_words ||= @translations.t(:mega).drop(2).flat_map { |key| @translations.t(key).values }
            @mega_words.include?(word)
          end

          def starter_suffix?(word, starters)
            starters.any? { |starter| word.end_with?(starter) }
          end

          def one?
            words_in_capacity(@current_capacity) == [@translations.ones(1)]
          end

          def thousand?
            @current_capacity == FiguresArray::THOUSAND_CAPACITY
          end

          def maybe_remove_zero
            @options.remove_zero&.result
          end
        end
      end
    end
  end
end
