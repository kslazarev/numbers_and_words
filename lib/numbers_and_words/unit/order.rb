# frozen_string_literal: true

module NumbersAndWords
  module Unit
    # Where a whole number goes relative to its unit, from the locale's numbers.unit_order; without it the number
    # comes first. after: lists the counts that follow the unit (Hebrew "שקל אחד", Arabic "دينار واحد"), alone: the
    # counts that the unit's form says by itself (the Arabic dual "ديناران"), and repeated_after_hundred: the last
    # two digits of counts above 100 that repeat the unit after the rest of the count (Arabic 101 is مائة دينار ودينار,
    # 102 مائة دينار وديناران; see Unit.whole_phrase). An ordinal in such a language follows its noun with an article,
    # which isn't supported.
    module Order
      module_function

      def phrase(count, words, form, options)
        order = I18n.t('numbers.unit_order', locale: I18n.local_language, default: {})
        return Unit.join(words, form) if order.empty?

        check!(options)
        return form if order.fetch(:alone, []).include?(count)

        order.fetch(:after, []).include?(count) ? Unit.join(form, words) : Unit.join(words, form)
      end

      def check!(options)
        raise UnsupportedOptionError, "A unit cannot be used with ordinal: true in #{::I18n.locale.inspect} yet." if options[:ordinal]
      end

      # The last two digits of a count above 100 that repeats its unit after the rest of the count, or nil.
      def repeated(count)
        return unless count > 100

        rest = count % 100
        order = I18n.t('numbers.unit_order', locale: I18n.local_language, default: {})
        rest if order.fetch(:repeated_after_hundred, []).include?(rest)
      end
    end
  end
end
