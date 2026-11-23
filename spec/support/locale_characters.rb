# frozen_string_literal: true

module LocaleCharacters
  def self.strings(value, path = [])
    case value
    when Hash
      value.flat_map { |key, entry| strings(entry, path + [key]) }
    when Array
      value.each_with_index.flat_map { |entry, index| strings(entry, path + [index]) }
    when String
      [[path.join('.'), value]]
    else
      []
    end
  end

  # script is a Unicode script name, or a list of them for a locale written in several (Japanese kanji and kana);
  # allowed lists invisible characters the orthography requires, such as the Persian zero-width non-joiner.
  def self.errors(value, script, allowed: '')
    letter = Regexp.new("\\A[#{Array(script).map { |name| "\\p{#{name}}" }.join}]\\z")

    strings(value).flat_map do |path, text|
      problems(text, letter, allowed).map { |problem| "#{path}: #{text.dump} (#{problem})" }
    end
  end

  def self.problems(text, letter, allowed = '')
    foreign = text.scan(/\p{L}/).grep_v(letter).uniq
    problems = []
    problems << "unexpected letters #{foreign.map { |character| format('U+%04X', character.ord) }.join(', ')}" unless foreign.empty?
    problems << 'not NFC-normalized' unless text.unicode_normalized?(:nfc)
    problems << 'invisible control/format characters' if text.delete(allowed).match?(/[\p{Cc}\p{Cf}\p{Default_Ignorable_Code_Point}\p{Zl}\p{Zp}]/)
    problems
  end
end
