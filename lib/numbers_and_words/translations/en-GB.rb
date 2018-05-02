# frozen_string_literal: true

module NumbersAndWords
  module Translations
    class EnGb < Base
      include NumbersAndWords::Translations::Families::Latin
      include NumbersAndWords::Translations::Extensions::FractionSignificance
    end
  end
end
