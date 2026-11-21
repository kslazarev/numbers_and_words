# frozen_string_literal: true

# Parses documented examples without evaluating them. An example is a line
#   I18n.with_locale(:en) { 21.to_words(ordinal: true) }
# followed by "# => <inspected result>". Only a locale, a number or an array
# of numbers, and options with literal values (true, false, integers, symbols
# and plain double-quoted strings) are accepted.
module DocumentationExamples
  NUMBER = /-?\d[\d_]*(?:\.\d+)?/
  RECEIVER = /#{NUMBER}|\[#{NUMBER}(?:, #{NUMBER})*\]/
  VALUE = /true|false|:\w+|-?\d+|"[^"\\#]*"/
  OPTION = /\w+: #{VALUE}/
  CALL = /\AI18n\.with_locale\(:(?:(?<locale>[a-z]{2})|'(?<locale>[a-z]{2}-[A-Z]{2})')\) \{ (?<receiver>#{RECEIVER})\.to_words(?:\((?<options>#{OPTION}(?:, #{OPTION})*)\))? \}\z/

  Example = Struct.new(:path, :line, :code, :locale, :receiver, :options, :expected)

  module_function

  def from(path, relative_path)
    File.readlines(path, chomp: true).each_cons(2).with_index.filter_map do |(code, result), index|
      next unless code.start_with?('I18n.with_locale')

      parse(relative_path, index + 1, code, result)
    end
  end

  def parse(path, line, code, result)
    match = CALL.match(code)
    raise ArgumentError, "#{path}:#{line}: unsupported example #{code.inspect}" unless match
    raise ArgumentError, "#{path}:#{line}: missing '# => ' result" unless result.start_with?('# => ')

    Example.new(path, line, code, match[:locale].to_sym, receiver(match[:receiver]), options(match[:options]), result.delete_prefix('# => '))
  end

  def receiver(text)
    text.start_with?('[') ? text[1..-2].split(', ').map { |item| number(item) } : number(text)
  end

  def number(text)
    text.include?('.') ? Float(text.delete('_')) : Integer(text.delete('_'), 10)
  end

  def options(text)
    return {} unless text

    text.split(', ').to_h do |pair|
      key, value = pair.split(': ', 2)
      [key.to_sym, literal(value)]
    end
  end

  def literal(text)
    case text
    when 'true' then true
    when 'false' then false
    when /\A:(\w+)\z/ then Regexp.last_match(1).to_sym
    when /\A"(.*)"\z/ then Regexp.last_match(1)
    else Integer(text, 10)
    end
  end
end
