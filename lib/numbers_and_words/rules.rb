# frozen_string_literal: true

require 'concurrent/map'
require 'numbers_and_words/rules/keys'

module NumbersAndWords
  # Spells a whole number from a locale's rule sets (numbers.rules), following the idea of Unicode CLDR's
  # rule-based number format: a small engine, with everything about a language kept in its locale file.
  #
  # A rule set maps the smallest number each rule applies to onto a template. The rule for a number (below
  # 10**limit, when there is a limit) is the one with the largest key not above it, and its divisor is the largest
  # power of ten not above that key, which splits the number into a quotient and a remainder; a key such as
  # '1100/100' gives the divisor itself, and a key such as '100*1000' repeats the rule at 100, 100 000,
  # 100 000 000 and so on below the limit. A template is text with these parts:
  #
  #   {list}   the word at the quotient in a word list, the plural form of a scale word for the quotient, or a
  #            single word
  #   {list%}  the word at the remainder in a word list
  #   {list*6} the word once for every 6 zeros of the rule's divisor, such as Thai ล้าน for each million
  #   {<}      the quotient spelled with the same rule set; {<set} with another one
  #   {>}      the remainder spelled with the rule set named by `then` (the same one by default); {>set} with another
  #   {=}      the whole number spelled with the rule set named by `then`; {=set} with another
  #   [...]    included only when the remainder isn't zero
  #   [...|...] the first part when the remainder isn't zero, the second when it is
  #
  # A rule set can name another with `extends` and override some of its rules. Words are looked up under the
  # `words:` scopes first, in order (such as "cases.genitive"), then at the top level, so a scope only lists what
  # differs.
  #
  # Each locale's rule sets are compiled once, into rules sorted by key with their templates already split into
  # text and tokens, and each word name is resolved once per set of scopes. The compiled form is kept by locale
  # with the numbers.rules it was built from, and dropped when I18n returns other rules, reloads or stores
  # translations.
  class Rules
    include Keys

    TOKEN = /\{([<>=])?([^}%]*)(%)?\}/
    OPTIONAL = /\[([^\]|]*)(?:\|([^\]]*))?\]/

    # A rule: the smallest number it applies to, its divisor, and its template's parts when the remainder isn't
    # zero and when it is.
    Rule = Struct.new(:base, :divisor, :parts, :zero_parts)
    # A {token}: a word at the quotient or the remainder (:word, :remainder_word) with its name, or the quotient,
    # the remainder or the whole number (:quotient, :remainder, :whole) with the rule set that spells it.
    Token = Struct.new(:kind, :name)
    KINDS = { '<' => :quotient, '>' => :remainder, '=' => :whole }.freeze

    # By locale.
    COMPILED = Concurrent::Map.new

    # The compiled rule sets and resolved words of the current locale, where a caller can keep other data about
    # the locale's numbers too.
    def self.compiled(translations)
      definitions = translations.t(:rules)
      compiled = COMPILED[::I18n.locale]
      return compiled if compiled && compiled[:definitions].equal?(definitions)

      COMPILED[::I18n.locale] = Concurrent::Map.new.tap do |entry|
        entry[:definitions] = definitions
        %i[sets words plurals].each { |key| entry[key] = Concurrent::Map.new }
      end
    end

    def self.clear
      COMPILED.clear
    end

    # Drops the compiled rule sets and the supported options when I18n's Simple backend reloads or stores
    # translations, which may change numbers.rules, numbers.supported_options or the words in place.
    module Invalidation
      def store_translations(...)
        super.tap { Invalidation.clear }
      end

      def reload!(...)
        super.tap { Invalidation.clear }
      end

      def self.clear
        Rules.clear
        OptionsValidation.clear
      end
    end

    def initialize(translations, limit, words: nil, compiled: Rules.compiled(translations))
      @translations = translations
      @limit = limit
      @maximum = 10**limit if limit
      @scopes = Array(words).freeze
      @compiled = compiled
      @definitions = compiled[:definitions]
      @words = compiled[:words].compute_if_absent(@scopes) { Concurrent::Map.new }
    end

    def spell(number, set_name)
      expand(number, set_name.to_s).squeeze(' ').strip
    end

    private

    def expand(number, set_name)
      raise Translations::Families::Base.range_error(@limit) if @maximum && number >= @maximum

      rule = rule_set(set_name).find { |candidate| candidate.base <= number }
      quotient, remainder = number.divmod(rule.divisor)
      (remainder.zero? ? rule.zero_parts : rule.parts).map do |part|
        part.is_a?(String) ? part : spell_token(part, number, quotient, remainder)
      end.join
    end

    def spell_token(token, number, quotient, remainder)
      case token.kind
      when :quotient then expand(quotient, token.name)
      when :remainder then expand(remainder, token.name)
      when :whole then expand(number, token.name)
      else word(token.name, token.kind == :remainder_word ? remainder : quotient)
      end
    end

    def word(name, index)
      key, words = (@words[name] ||= resolve(name))
      return words if words.is_a?(String)

      words.is_a?(Hash) ? plural(key, index) : words.fetch(index)
    end

    # The plural form of a scale word, kept for the counts of up to three digits that rules give.
    def plural(key, count)
      return @translations.t(key, count:) if count >= 1000

      @compiled[:plurals][[key, count]] ||= @translations.t(key, count:)
    end

    # The key of a word under the first scope that has it, or at the top level, and its value.
    def resolve(name)
      path = name.split('.').map(&:to_sym)
      scope = @scopes.find { |candidate| !@translations.t(candidate).dig(*path).nil? }
      key = scope ? "#{scope}.#{name}" : name
      [key, @translations.t(key)]
    end

    def rule_set(name)
      @compiled[:sets][name] ||= compile(name)
    end

    # A rule set's rules from the largest key down, compiled from its own templates and those it extends, so that
    # {<} and {>} name the rule set being spelled.
    def compile(name)
      templates, then_name = templates(name)
      templates.map { |base, (key, template)| rule(base, key, template, name, then_name || name) }.sort_by { |rule| -rule.base }
    end

    # The templates of a rule set and those it extends by the smallest number they apply to, and its `then`.
    def templates(name)
      definition = @definitions.fetch(name.to_sym)
      inherited, inherited_then = definition[:extends] ? templates(definition[:extends].to_s) : [{}, nil]
      [inherited.merge(repeated(definition)).merge(own(definition)).compact, definition[:then]&.to_s || inherited_then]
    end

    def rule(base, key, template, name, next_name)
      divisor = divisor(key)
      template = repeat_words(template, divisor)
      Rule.new(base, divisor, parts(choose(template, false), name, next_name), parts(choose(template, true), name, next_name))
    end

    def choose(template, zero)
      template.gsub(OPTIONAL) { zero ? Regexp.last_match(2).to_s : Regexp.last_match(1) }
    end

    # The template's text and tokens, in order.
    def parts(template, name, next_name)
      template.split(/(\{[^}]*\})/).reject(&:empty?).map do |piece|
        piece.start_with?('{') ? token(piece, name, next_name) : piece
      end
    end

    # {<} spells with the same rule set by default, {>} and {=} with the one named by `then`.
    def token(piece, name, next_name)
      direction, word, at_remainder = piece.match(TOKEN).captures
      return Token.new(at_remainder ? :remainder_word : :word, word) unless direction

      default = direction == '<' ? name : next_name
      Token.new(KINDS.fetch(direction), word.empty? ? default : word)
    end
  end
end

I18n::Backend::Simple.prepend(NumbersAndWords::Rules::Invalidation)
