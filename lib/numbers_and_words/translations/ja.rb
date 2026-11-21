# frozen_string_literal: true

module NumbersAndWords
  module Translations
    # Japanese words come in two scripts, numbers.kanji and numbers.kana, chosen with the script option.
    class Ja < Base
      PLACES = %i[ones tens hundreds thousands].freeze

      # The kana endings that become a small っ (sokuon) before a scale word or 点 (てん), with the sounds
      # that cause it: いち, はち and じゅう before k, s and t sounds (いっちょう, はってん, じゅっけい), ろく and
      # ひゃく only before k sounds (ろっけい, ひゃっけい, but ろくちょう, ひゃくちょう).
      SOKUON = {
        'いち' => ['いっ', /\A[かきくけこさしすせそたちつてと]/],
        'はち' => ['はっ', /\A[かきくけこさしすせそたちつてと]/],
        'じゅう' => ['じゅっ', /\A[かきくけこさしすせそたちつてと]/],
        'ろく' => ['ろっ', /\A[かきくけこ]/],
        'ゃく' => ['ゃっ', /\A[かきくけこ]/]
      }.freeze

      # A digit at a place of its group: 3 at the hundreds is 三百 (さんびゃく).
      def digit(digit, power, script)
        words(script)[PLACES[power]][digit]
      end

      def ones(digit, script = :kanji)
        digit(digit, 0, script)
      end

      def scale(index, script)
        words(script)[:scales][index] || raise(RangeError, "10^#{index * 4} is beyond the largest Japanese scale")
      end

      def ordinal_prefix(script)
        words(script)[:ordinal_prefix]
      end

      def micro_separator(script = :kanji)
        words(script)[:micro_separator]
      end

      # Joins a number and the word after it, applying the kana sound changes (一兆 is いっちょう).
      def join(left, right, script)
        return left + right unless script == :kana

        ending, (replacement, sounds) = SOKUON.find { |suffix, _| left.end_with?(suffix) }
        ending && right.match?(sounds) ? left.delete_suffix(ending) + replacement + right : left + right
      end

      private

      def words(script)
        t(script)
      end
    end
  end
end
