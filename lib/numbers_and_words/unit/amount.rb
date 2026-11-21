# frozen_string_literal: true

module NumbersAndWords
  module Unit
    # The subunit option: an amount in a unit and a subunit, such as dollars and cents.
    module Amount
      SUBUNIT_PLACES = 2

      module_function

      # An amount in a unit and a subunit: "twenty-one dollars and fifty cents". precision: sets how many
      # decimal places make one subunit (2 by default), and the amount is rounded half to even to them.
      # A zero subunit is left out unless zero_subunit: true, and a zero unit with remove_zero: true. A negative
      # amount starts with the minus word, unless it rounds to zero.
      def words(number, unit, subunit, options)
        raise UnsupportedOptionError, 'subunit cannot be used with ordinal: true' if options[:ordinal]

        whole, part = split(number, options.fetch(:precision, SUBUNIT_PLACES))
        conversion = options.except(:precision, :remove_zero, :zero_subunit)
        text = amount_parts(whole, part, unit, subunit, options).map { |count, key| Unit.phrase(count, key, conversion) }.join(subunit_separator)
        number.negative? && (whole + part).positive? ? Wrappers::Sign.prefix(text) : text
      end

      def amount_parts(whole, part, unit, subunit, options)
        parts = []
        parts << [whole, unit] unless whole.zero? && part.positive? && options[:remove_zero]
        parts << [part, subunit] if part.positive? || options[:zero_subunit]
        parts
      end

      def split(number, places)
        raise UnsupportedOptionError, 'subunit needs precision: of at least 1' if places.zero?

        value = Rational(number.to_s).abs.round(places, half: :even)
        whole = value.to_i
        [whole, ((value - whole) * (10**places)).to_i]
      end

      # The word between a unit and its subunit, from the locale ("and" in English), or a plain separator. With
      # numbers.subunit_separator_attached: true it is a prefix of the next word (Hebrew and Arabic "ו", "و").
      def subunit_separator
        language = I18n.local_language
        word = ::I18n.t('numbers.subunit_separator', locale: language, default: '')
        return Unit.separator if word.empty?

        ::I18n.t('numbers.subunit_separator_attached', locale: language, default: false) ? " #{word}" : " #{word} "
      end
    end
  end
end
