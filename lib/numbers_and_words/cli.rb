# frozen_string_literal: true

require 'optparse'
require 'numbers_and_words'

module NumbersAndWords
  # The to_words command: spells out numbers, one result per line.
  class CLI
    class Error < StandardError; end

    DESCRIPTIONS = {
      animate: 'Use the animate accusative, e.g. Russian "первого"',
      apocopated: 'Use the shortened form, e.g. Spanish "un"',
      case: 'Grammatical case, e.g. genitive or dative',
      fraction: 'Read decimals as a fraction, e.g. "one and five tenths"',
      gender: 'Grammatical gender, e.g. male, female, neuter or common',
      hundreds_with_union: 'Say "and" after hundreds',
      micro_separator: 'Word between the integral and fractional parts',
      ordinal: 'Spell ordinal numbers',
      precision: 'Pad the fractional part to N digits',
      pronounced: 'Read four-digit numbers as they are spoken',
      remove_hyphen: 'Remove the hyphen between tens and ones',
      remove_zero: 'Omit a zero integral part',
      script: 'Writing system, e.g. Japanese kanji or kana',
      spelling: 'Spelling, e.g. French reformed (1990) or traditional',
      tens_of_hundreds: 'Read thousands as tens of hundreds',
      subunit: 'Spell the decimal places as a second unit, e.g. cents, under units.VALUE',
      unit: 'Append a unit translated by the application under units.VALUE',
      zero_subunit: 'Spell a zero subunit, e.g. "zero cents"'
    }.freeze

    def self.start(argv = ARGV, stdin: $stdin, stdout: $stdout, stderr: $stderr)
      new(stdin:, stdout:, stderr:).run(argv)
    end

    # Every option any bundled language accepts: name => [check, locales accepting it].
    def self.options
      @options ||= I18n.languages.sort.each_with_object({}) do |locale, table|
        OptionsValidation.supported_options(locale).each { |name, check| (table[name] ||= [check, []])[1] << locale }
      end.sort.to_h
    end

    def initialize(stdin: $stdin, stdout: $stdout, stderr: $stderr)
      @stdin = stdin
      @stdout = stdout
      @stderr = stderr
      @locale = :en
      @options = {}
    end

    def run(argv)
      arguments = parser.parse(argv)
      return 0 if @done

      numbers = read_numbers(arguments)
      @stdout.puts(::I18n.with_locale(@locale) { numbers.map { |number| number.to_words(@options) } })
      0
    rescue Error, OptionParser::ParseError, ArgumentError => e
      # ArgumentError covers NumbersAndWords::UnsupportedOptionError and invalid I18n locales.
      @stderr.puts "to_words: #{e.message}", parser.banner
      1
    end

    private

    def parser
      @parser ||= OptionParser.new do |opts|
        opts.banner = 'Usage: to_words [options] [NUMBER...]'
        opts.separator ''
        opts.separator 'Spells out each NUMBER, or whitespace-separated numbers read from standard input.'
        opts.separator ''
        opts.on('-l', '--locale LOCALE', 'Locale to spell numbers in (default: en)') { |value| @locale = value.to_sym }
        define_conversion_options(opts)
        define_informational_options(opts)
      end
    end

    def define_informational_options(opts)
      opts.separator ''
      opts.on('-v', '--version', 'Show version') { finish(NumbersAndWords::VERSION) }
      opts.on('-h', '--help', 'Show this help') { finish(opts.help) }
    end

    def finish(message)
      @stdout.puts message
      @done = true
    end

    def read_numbers(arguments)
      numbers = arguments.empty? ? @stdin.read.split : arguments
      raise Error, 'no numbers given' if numbers.empty?

      numbers.map { |number| parse_number(number) }
    end

    # One flag per to_words option known to any language; to_words validates
    # each option for the selected language.
    def define_conversion_options(opts)
      opts.separator ''
      opts.separator 'Options, each supported by the languages listed (validated for the selected locale):'
      self.class.options.each do |name, (check, locales)|
        opts.on(*flag(name, check), description(name, locales)) { |value| @options[name] = value }
      end
    end

    def flag(name, check)
      flag = name.to_s.tr('_', '-')
      case check
      when OptionsValidation::BOOLEAN then ["--[no-]#{flag}"]
      when OptionsValidation::GLOBAL[:precision] then ["--#{flag} N", Integer]
      else ["--#{flag} VALUE"]
      end
    end

    def description(name, locales)
      languages = locales.size == I18n.languages.size ? 'all' : locales.join(', ')
      "#{DESCRIPTIONS.fetch(name) { name.to_s.tr('_', ' ').capitalize }} (#{languages})"
    end

    def parse_number(text)
      return Integer(text, 10) if /\A[+-]?\d+\z/.match?(text)
      return Float(text) if /\A[+-]?\d+\.\d+\z/.match?(text)

      raise Error, "not a number: #{text.inspect}"
    end
  end
end
