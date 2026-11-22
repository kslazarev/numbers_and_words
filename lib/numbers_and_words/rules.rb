# frozen_string_literal: true

module NumbersAndWords
  # Spells a whole number from a locale's rule sets (numbers.rules), following the idea of Unicode CLDR's
  # rule-based number format: a small engine, with everything about a language kept in its locale file.
  #
  # A rule set maps the smallest number each rule applies to onto a template. The rule for a number is the one
  # with the largest key not above it, and its divisor is the largest power of ten not above that key, which
  # splits the number into a quotient and a remainder. A template is text with these parts:
  #
  #   {list}   the word at the quotient in a word list, the plural form of a scale word for the quotient, or a
  #            single word
  #   {list%}  the word at the remainder in a word list
  #   {<}      the quotient spelled with the same rule set; {<set} with another one
  #   {>}      the remainder spelled with the rule set named by `then` (the same one by default); {>set} with another
  #   [...]    included only when the remainder isn't zero
  #   [...|...] the first part when the remainder isn't zero, the second when it is
  #
  # A rule set can name another with `extends` and override some of its rules. Words are looked up under the
  # `words:` scope first (such as "cases.genitive"), then at the top level, so a scope only lists what differs.
  class Rules
    TOKEN = /\{([<>])?([^}%]*)(%)?\}/
    OPTIONAL = /\[([^\]|]*)(?:\|([^\]]*))?\]/

    def initialize(translations, limit, words: nil)
      @translations = translations
      @limit = limit
      @scope = words
    end

    def spell(number, set_name)
      expand(number, set_name).squeeze(' ').strip
    end

    private

    def expand(number, set_name)
      raise Translations::Families::Base.range_error(@limit) if number >= 10**@limit

      rules = rule_set(set_name)
      key, template = rule_for(rules, number)
      quotient, remainder = number.divmod(10**(key.to_s.length - 1))
      choose(template, remainder).gsub(TOKEN) do
        token(Regexp.last_match, rules.fetch(:then, set_name), set_name, quotient, remainder)
      end
    end

    def choose(template, remainder)
      template.gsub(OPTIONAL) { remainder.zero? ? Regexp.last_match(2).to_s : Regexp.last_match(1) }
    end

    def token(match, next_set, set_name, quotient, remainder)
      direction, name, at_remainder = match.captures
      case direction
      when '<' then expand(quotient, name.empty? ? set_name : name)
      when '>' then expand(remainder, name.empty? ? next_set : name)
      else word(name, at_remainder ? remainder : quotient)
      end
    end

    def word(name, index)
      key = scoped?(name) ? "#{@scope}.#{name}" : name
      words = @translations.t(key)
      return words if words.is_a?(String)

      words.is_a?(Hash) ? @translations.t(key, count: index) : words.fetch(index)
    end

    def scoped?(name)
      @scope && !@translations.t(@scope).dig(*name.split('.').map(&:to_sym)).nil?
    end

    def rule_for(rules, number)
      rules.select { |key, _| key.is_a?(Integer) && key <= number }.max_by(&:first)
    end

    def rule_set(name)
      (@rule_sets ||= {})[name] ||= begin
        rules = @translations.t(:rules).fetch(name.to_sym)
        base = rules[:extends] ? rule_set(rules[:extends]) : {}
        base.merge(rules.except(:extends))
      end
    end
  end
end
