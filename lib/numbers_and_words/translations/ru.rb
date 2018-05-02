# frozen_string_literal: true

module NumbersAndWords
  module Translations
    class Ru < Base
      include NumbersAndWords::Translations::Families::Cyrillic
      include NumbersAndWords::Translations::Extensions::FractionSignificance
    end
  end
end
