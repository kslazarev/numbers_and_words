# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        # Turns the cardinal words of an integer into an ordinal when ordinal: true. A language prepends
        # this module and implements ordinal_words(text, ordinal_integer), using the words in its locale file under
        # numbers.ordinals. Decimals, and either part of one, keep the cardinal form.
        module Ordinals
          def words
            text = super
            ordinal_number? && !text.empty? ? ordinal_words(text, ordinal_integer) : text
          end

          private

          def ordinal_number?
            @options.ordinal&.result && @options.options[:integral].nil? && @options.options[:fractional].nil?
          end

          def ordinal_integer
            @figures.to_a.reverse.join.to_i
          end

          def ordinals
            @ordinals ||= @translations.t(:ordinals)
          end

          # The word with the longest suffix found in the table replaced by its value, or nil.
          def replace_suffix(word, table)
            suffix = table.keys.map(&:to_s).select { |key| word.end_with?(key) }.max_by(&:length)
            suffix && "#{word.delete_suffix(suffix)}#{table[suffix.to_sym]}"
          end

          # The ordinal adjective in the gender and case asked for: gender: and case: pick an ending table from
          # numbers.ordinals.endings, and a missing table keeps the masculine nominative form.
          def declined(ordinal)
            endings = ordinals.dig(:endings, ordinal_gender || :male, ordinal_case)
            (endings && replace_suffix(ordinal, endings)) || ordinal
          end

          # The masculine accusative of an animate noun is its genitive ("вижу двадцать первого").
          def ordinal_case
            grammatical_case = @options.options.fetch(:case, :nominative).to_sym
            animate = @options.animate&.result && grammatical_case == :accusative && [nil, :male].include?(ordinal_gender)
            animate ? :genitive : grammatical_case
          end

          def ordinal_gender
            @options.options[:gender]&.to_sym
          end
        end
      end
    end
  end
end
