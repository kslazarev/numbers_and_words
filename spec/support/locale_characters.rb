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

  def self.errors(value, script)
    letter = Regexp.new("\\A\\p{#{script}}\\z")

    strings(value).flat_map do |path, text|
      problems(text, letter).map { |problem| "#{path}: #{text.dump} (#{problem})" }
    end
  end

  def self.problems(text, letter)
    foreign = text.scan(/\p{L}/).grep_v(letter).uniq
    problems = []
    problems << "unexpected letters #{foreign.map { |character| format('U+%04X', character.ord) }.join(', ')}" unless foreign.empty?
    problems << 'not NFC-normalized' unless text.unicode_normalized?(:nfc)
    problems << 'invisible control/format characters' if text.match?(/[\p{Cc}\p{Cf}\p{Default_Ignorable_Code_Point}\p{Zl}\p{Zp}]/)
    problems
  end
end
