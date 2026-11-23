# frozen_string_literal: true

module NumbersAndWords
  module Unit
    # The form a whole number takes before a unit, where it differs from the counting form, from the locale's
    # numbers.before_unit. whole: replaces a reading that is exactly the key (Italian "uno" gives "un euro", Hebrew
    # "שניים" gives "שני שקלים"); endings: replaces the end of a reading (German "einhunderteins" gives
    # "einhundertein Euro", Hungarian "huszonkettő" gives "huszonkét forint"). A value is a word, or one word per
    # gender of the unit with other for the rest: { other: ein, female: eine } gives "ein Euro" and "eine Mark".
    module BeforeNoun
      module_function

      def apply(words, gender)
        forms = I18n.t('numbers.before_unit', locale: I18n.local_language, default: {})
        return words if forms.empty?

        whole = forms.fetch(:whole, {})[words.to_sym]
        return choose(whole, gender) if whole

        ending(words, forms.fetch(:endings, {}), gender)
      end

      def ending(words, endings, gender)
        suffix = endings.keys.map(&:to_s).select { |key| words.end_with?(key) }.max_by(&:length)
        suffix ? "#{words.delete_suffix(suffix)}#{choose(endings[suffix.to_sym], gender)}" : words
      end

      def choose(value, gender)
        return value unless value.is_a?(Hash)

        value.fetch(gender&.to_sym) { value.fetch(:other) }
      end
    end
  end
end
