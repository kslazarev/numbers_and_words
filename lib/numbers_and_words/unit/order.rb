# frozen_string_literal: true

module NumbersAndWords
  module Unit
    # Where a whole number goes relative to its unit, from the locale's numbers.unit_order; without it the number
    # comes first. after: lists the counts that follow the unit (Hebrew "שקל אחד", Arabic "دينار واحد"), alone: the
    # counts that the unit's form says by itself (the Arabic dual "ديناران"), and unsupported_after_hundred: the last
    # two digits of counts above 100 that raise, because the unit form they need isn't a plural category (Arabic
    # 101 repeats the unit: مائة دينار ودينار). An ordinal in such a language follows its noun with an article, which
    # isn't supported either.
    module Order
      module_function

      def phrase(count, words, form, options)
        order = I18n.t('numbers.unit_order', locale: I18n.local_language, default: {})
        return Unit.join(words, form) if order.empty?

        check!(count, order, options)
        return form if order.fetch(:alone, []).include?(count)

        order.fetch(:after, []).include?(count) ? Unit.join(form, words) : Unit.join(words, form)
      end

      def check!(count, order, options)
        raise UnsupportedOptionError, "A unit cannot be used with ordinal: true in #{::I18n.locale.inspect} yet." if options[:ordinal]
        return unless count > 100 && order.fetch(:unsupported_after_hundred, []).include?(count % 100)

        raise UnsupportedNumberError, "A unit after #{count} is not supported in #{::I18n.locale.inspect} yet."
      end
    end
  end
end
