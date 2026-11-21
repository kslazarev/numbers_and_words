# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Options
        module Ja
          # script: :kanji (the default) writes kanji numerals (三百); script: :kana writes their reading in
          # hiragana (さんびゃく).
          class Script
            VALUES = %i[kanji kana].freeze

            def initialize(proxy, *_args)
              @options = proxy.options
            end

            def result
              @options[:script]&.to_sym || :kanji
            end
          end
        end
      end
    end
  end
end
