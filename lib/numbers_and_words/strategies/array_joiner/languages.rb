# frozen_string_literal: true

require 'numbers_and_words/i18n'
require 'numbers_and_words/strategies/array_joiner/languages/families/base'

require 'numbers_and_words/strategies/array_joiner/languages/base'

require 'numbers_and_words/strategies/array_joiner/languages/ja'

module NumbersAndWords
  module Strategies
    module ArrayJoiner
      module Languages
        # A language without a joiner of its own joins with Languages::Base, under its name (ArrayJoiner::Languages::Sv).
        I18n.define_classes(self) { Class.new(Base) }

        class << self
          def factory(strategy)
            Object.const_get("#{name}::#{I18n.language_class_name}").new strategy
          end
        end
      end
    end
  end
end
