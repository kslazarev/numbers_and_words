# frozen_string_literal: true

module NumbersAndWords
  module Translations
    # The words of whole numbers are read from the locale file by Strategies::FiguresConverter::Languages::Ja.
    class Ja < Base
      SOKUON = {
        'いち' => ['いっ', /\A[かきくけこさしすせそたちつてと]/],
        'はち' => ['はっ', /\A[かきくけこさしすせそたちつてと]/],
        'じゅう' => ['じゅっ', /\A[かきくけこさしすせそたちつてと]/],
        'ろく' => ['ろっ', /\A[かきくけこ]/],
        'ゃく' => ['ゃっ', /\A[かきくけこ]/]
      }.freeze

      def ones(digit, script = :kanji)
        t(script)[:ones][digit]
      end

      def micro_separator(script = :kanji)
        t(script)[:micro_separator]
      end

      def join(left, right, script)
        return left + right unless script == :kana

        ending, (replacement, sounds) = SOKUON.find { |suffix, _| left.end_with?(suffix) }
        ending && right.match?(sounds) ? left.delete_suffix(ending) + replacement + right : left + right
      end
    end
  end
end
