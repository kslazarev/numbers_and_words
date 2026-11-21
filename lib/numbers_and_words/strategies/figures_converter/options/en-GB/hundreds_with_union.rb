# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Options
        module EnGb
          # British English says "one hundred and one", so the union is on unless explicitly disabled.
          class HundredsWithUnion < En::HundredsWithUnion
            private

            def active?
              @options.fetch(:hundreds_with_union, true)
            end
          end
        end
      end
    end
  end
end
