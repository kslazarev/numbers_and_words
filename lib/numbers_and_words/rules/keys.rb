# frozen_string_literal: true

module NumbersAndWords
  class Rules
    # The keys of a rule set: the smallest number a rule applies to and its divisor, from 100, '1100/100' or
    # '100*1000'.
    module Keys
      RATIO = %r{\A(\d+)/(\d+)\z}
      REPEAT = /\A(\d+)\*(\d+)\z/
      REPEATED_WORD = /\{([^}<>=%*]+)\*(\d+)\}/
      # The largest rule a repeated key reaches in a language without a limit, as Thai is.
      UNLIMITED = 10**120

      private

      # The rules of a rule set's own keys; a key set to ~, as in a locale that extends another, drops the rule.
      def own(definition)
        definition.filter_map { |key, template| [base(key), template && [key, template]] if base(key) }.to_h
      end

      # The rules of keys such as '100*1000', at every multiple below the limit; a key of its own overrides one.
      def repeated(definition)
        definition.each_with_object({}) do |(key, template), rules|
          repeats(key).each { |base| rules[base] = [base, template] }
        end
      end

      # 100, 100 000, 100 000 000 and so on for '100*1000', below the limit; nothing for another key.
      def repeats(key)
        match = key.to_s.match(REPEAT)
        return [] unless match

        start, step = match.captures.map(&:to_i)
        (0..).lazy.map { |power| start * (step**power) }.take_while { |base| base <= ceiling }.to_a
      end

      def ceiling
        @maximum ? @maximum - 1 : UNLIMITED
      end

      # {million*6} as {million} once for every 6 zeros of the divisor.
      def repeat_words(template, divisor)
        zeros = divisor.to_s.length - 1
        template.gsub(REPEATED_WORD) { "{#{Regexp.last_match(1)}}" * (zeros / Regexp.last_match(2).to_i) }
      end

      # The smallest number a key's rule applies to.
      def base(key)
        key.is_a?(Integer) ? key : key.to_s[RATIO, 1]&.to_i
      end

      # The largest power of ten not above the key, or the divisor a key such as '1100/100' gives.
      def divisor(key)
        key.is_a?(Integer) ? 10**(key.to_s.length - 1) : key.to_s[RATIO, 2].to_i
      end
    end
  end
end
