# frozen_string_literal: true

module NumbersAndWords
  module I18n
    module Plurals
      module Pl
        RULE = lambda do |number|
          next :other unless number.is_a?(Integer)

          number = number.abs
          next :one if number == 1

          (2..4).cover?(number % 10) && !(12..14).cover?(number % 100) ? :few : :many
        end
      end
    end
  end
end
