# frozen_string_literal: true

module CldrComparison
  # A reviewed transformation of CLDR's reading, from spec/fixtures/cldr_rules.yml,
  # applied before it is compared with the gem's. A rule does one literal
  # operation, without wildcards, so it cannot hide an unrelated difference:
  #
  # * replace: { from: to } replaces whole words or phrases, never part of a word;
  # * replace_parts: { from: to } replaces parts of words, such as a misspelled stem;
  # * drop_one: { one: [...], before: [...] } drops the implicit one, a word of one:
  #   before a scale word beginning with one of before:, at the start of the
  #   reading or after another such scale word;
  # * prefix: text added to the start of the reading; with before: [...], only
  #   when the reading starts with one of those words;
  # * split_before: [...] puts a space before these parts of words when they
  #   follow a letter;
  # * join_after: [...] and join_before: [...] remove the space after words
  #   ending in these, or before words beginning with these;
  # * hyphenate: [...] joins all words with hyphens except next to these words.
  #
  # ticket: names the CLDR Jira ticket reporting a CLDR error the rule works around.
  # kinds: limits a rule to some comparisons, and above: and below: to a range
  # of numbers. affects: is the number of comparisons whose reading the rule
  # changes, so that a rule absorbing a new kind of difference is noticed.
  class Rule
    LETTER = '[\p{L}\p{M}]'
    OPERATIONS = %w[replace replace_parts drop_one prefix split_before join_after join_before hyphenate].freeze
    SCOPES = %w[kinds above below].freeze
    TICKET = /\ACLDR-\d+\z/
    KEYS = (OPERATIONS + SCOPES + %w[before reason ticket affects]).freeze

    attr_reader :locale, :index, :definition

    def initialize(locale, index, definition)
      @locale = locale
      @index = index
      @definition = definition
      @pattern, @replacement = problems.empty? ? compile : [/(?!)/, '']
    end

    def name
      "#{locale} rule #{index + 1} (#{operation})"
    end

    def operation
      (definition.keys & OPERATIONS).first
    end

    def reason
      definition['reason']
    end

    def affects
      definition['affects']
    end

    def kinds
      definition['kinds']
    end

    def applies?(kind, number)
      (kinds.nil? || kinds.include?(kind)) &&
        (definition['above'].nil? || number > definition['above']) &&
        (definition['below'].nil? || number < definition['below'])
    end

    def apply(words)
      return hyphenated(words) if operation == 'hyphenate'

      words.gsub(@pattern, @replacement)
    end

    # Problems with the rule's own definition, independent of the comparisons.
    def problems
      key_problems + value_problems
    end

    private

    def key_problems
      unknown = definition.keys - KEYS
      {
        'needs exactly one operation' => !(definition.keys & OPERATIONS).one?,
        "has unknown keys #{unknown.join(', ')}" => !unknown.empty?,
        'has before: without prefix:' => definition.key?('before') && operation != 'prefix'
      }.select { |_, problem| problem }.keys
    end

    def value_problems
      {
        'needs a reason' => reason.to_s.strip.empty? || reason == 'TODO',
        'needs an affects: count' => !affects.is_a?(Integer),
        'has a ticket: that is not a CLDR Jira key such as CLDR-19918' => !TICKET.match?(definition.fetch('ticket', 'CLDR-0').to_s)
      }.select { |_, problem| problem }.keys
    end

    def alternatives(values)
      Array(values).sort_by { |value| -value.length }.map { |value| Regexp.escape(value) }.join('|')
    end

    def compile
      case operation
      when 'replace', 'replace_parts' then replacement
      when 'drop_one' then drop_one
      when 'prefix' then prefix
      else separator
      end
    end

    def separator
      words = alternatives(definition[operation])
      case operation
      when 'split_before' then [/(?<=#{LETTER})(?=#{words})/, ' ']
      when 'join_after' then [/(?<=#{words}) (?=#{LETTER})/, '']
      when 'join_before' then [/(?<=#{LETTER}) (?=#{words})/, '']
      else [/(?!)/, '']
      end
    end

    def hyphenated(words)
      kept = definition['hyphenate']
      words.split.each_cons(2).reduce(words.split.first.to_s) do |joined, (previous, word)|
        "#{joined}#{kept.include?(previous) || kept.include?(word) ? ' ' : '-'}#{word}"
      end
    end

    def replacement
      substitutions = definition[operation].to_h
      found = alternatives(substitutions.keys)
      [operation == 'replace' ? /(?<!#{LETTER})(?:#{found})(?!#{LETTER})/ : /#{found}/, substitutions]
    end

    def drop_one
      table = definition['drop_one']
      after_scale = alternatives(Array(table['before']).map { |scale| "#{scale} " })
      [/(?:\A|(?<=#{after_scale}))(?:#{alternatives(table['one'])}) ?(?=#{alternatives(table['before'])})/, '']
    end

    def prefix
      before = definition['before']
      [before ? /\A(?=(?:#{alternatives(before)})(?!#{LETTER}))/ : /\A/, definition['prefix']]
    end
  end
end
