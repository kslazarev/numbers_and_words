# frozen_string_literal: true

module NumbersAndWords
  module I18n
    module Plurals
      # Slovak takes the singular after 1, the nominative plural after 2 to 4 and the genitive plural otherwise,
      # also after compounds such as 21 or 22 (CLDR: one, few, other).
      module Sk
        RULE = lambda do |number|
          if number == 1
            :one
          elsif (2..4).cover?(number)
            :few
          else
            :other
          end
        end
      end
    end
  end
end
