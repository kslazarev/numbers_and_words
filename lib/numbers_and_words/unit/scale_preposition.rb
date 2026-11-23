# frozen_string_literal: true

module NumbersAndWords
  module Unit
    # A whole number that ends in a scale noun of a million or more ("um milhão", "mil milhões", "mil millones")
    # takes the locale's numbers.unit_scale_preposition before the unit: "um milhão de reais", "un milione di euro".
    # Before a unit form that starts with one of the letters under numbers.unit_scale_preposition_elided_before,
    # numbers.unit_scale_preposition_elided replaces it: "un million d'euros". A unit translation sets
    # elision: true for a mute h (d'hectares) or false for any other exception.
    # The number ends in a scale noun when its last six digits are zero: whatever the scale, its last non-zero
    # group of three digits is then a million or larger, with no number after it.
    module ScalePreposition
      SCALE = 10**6

      module_function

      def apply(form, number, entry)
        preposition = word('unit_scale_preposition')
        return form if preposition.empty? || !scale_final?(number)

        elided = word('unit_scale_preposition_elided')
        elided.empty? || !elide?(form, entry) ? "#{preposition} #{form}" : "#{elided}#{form}"
      end

      def scale_final?(number)
        !number.zero? && (number % SCALE).zero?
      end

      def elide?(form, entry)
        return entry[:elision] if entry.is_a?(Hash) && entry.key?(:elision)

        letters = word('unit_scale_preposition_elided_before')
        !letters.empty? && form.match?(/\A[#{Regexp.escape(letters)}]/i)
      end

      def word(name)
        I18n.t("numbers.#{name}", locale: I18n.local_language, default: '')
      end
    end
  end
end
