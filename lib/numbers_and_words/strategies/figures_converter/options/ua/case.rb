# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Options
        module Ua
          # Grammatical case of an ordinal; the default is :nominative.
          class Case
            VALUES = %i[nominative genitive dative accusative instrumental prepositional vocative].freeze
          end
        end
      end
    end
  end
end
