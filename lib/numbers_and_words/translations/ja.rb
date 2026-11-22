# frozen_string_literal: true

module NumbersAndWords
  module Translations
    # The words of whole numbers are read from the locale file by Strategies::FiguresConverter::Languages::Ja.
    class Ja < Base
      def ones(digit, script = :kanji)
        t(script)[:ones][digit]
      end

      def micro_separator(script = :kanji)
        t(script)[:micro_separator]
      end

      # In kana, an ending under numbers.kana.sokuon doubles the next consonant before the sounds it lists
      # ("いっせん").
      def join(left, right, script)
        return left + right unless script == :kana

        ending, change = t(:kana)[:sokuon].find { |suffix, _| left.end_with?(suffix.to_s) }
        ending && change[:before].include?(right[0]) ? left.delete_suffix(ending.to_s) + change[:to] + right : left + right
      end
    end
  end
end
