# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        class It < Base
          prepend Ordinals

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
            return words + [@translations.t(:fractional_one)] if one?

            # "ventun milioni": a final "uno" drops its "o" before the plural scale nouns
            capacity_words = [*capacity_words[0...-1], capacity_words.last.sub(/tuno\z/, 'tun')] unless thousand? || capacity_words.empty?
            words + capacity_words
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

          # Italian ordinals above ten are one word: the cardinal drops its final vowel and takes -esimo
          # ("ventunesimo", "duemillesimo"); an accented final vowel loses its accent ("ventitreesimo").
          def ordinal_words(text, number)
            return text if number.zero?
            return ordinals[:units][number] if number <= 10

            word = without_leading_one(text).delete(' ')
            thousands = ordinals[:thousands]
            return "#{word.delete_suffix(thousands)}#{ordinals[:thousandth]}" if word.end_with?(thousands)

            "#{ordinal_stem(word)}#{ordinals[:suffix]}"
          end

          def ordinal_stem(word)
            return word if ordinals[:keep_vowel].any? { |ending| word.end_with?(ending) }
            return word.unicode_normalize(:nfd).sub(/\p{Mn}\z/, '').unicode_normalize(:nfc) if word.match?(/[àèéìòù]\z/)

            word[0..-2]
          end
        end
      end
    end
  end
end
