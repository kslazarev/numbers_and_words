# frozen_string_literal: true

module NumbersAndWords
  module I18n
    module Plurals
      # Romanian (CLDR): one for 1, few for 0 and counts ending in 01 to 19, and other for counts ending in 00 or
      # from 20, which take "de" before the noun (douăzeci de lei).
      module Ro
        RULE = lambda do |number|
          if number == 1
            :one
          elsif number.zero? || (1..19).cover?(number % 100)
            :few
          else
            :other
          end
        end
      end
    end
  end
end
