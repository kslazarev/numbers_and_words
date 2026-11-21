# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Decorators
        module Hu
          class Base < Decorators::Base
            private

            # A final two before a noun is két ("két egész két tized").
            def before_noun(words)
              translations = @strategy.translations
              words.sub(/#{translations.t(:ones)[2]}\z/, translations.t(:compound_two))
            end
          end
        end
      end
    end
  end
end
