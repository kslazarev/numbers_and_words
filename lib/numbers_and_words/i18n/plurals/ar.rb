# frozen_string_literal: true

module NumbersAndWords
  module I18n
    module Plurals
      # Arabic (CLDR): zero, one and two for 0, 1 and 2, few for counts ending in 03 to 10, which take the plural
      # (ثلاثة دنانير), many for counts ending in 11 to 99, which take the accusative singular (أحد عشر دينارًا), and
      # other for the rest, which take the genitive singular (مائة دينار).
      module Ar
        RULE = lambda do |number|
          case number
          when 0 then :zero
          when 1 then :one
          when 2 then :two
          else
            case number % 100
            when 3..10 then :few
            when 11..99 then :many
            else :other
            end
          end
        end
      end
    end
  end
end
