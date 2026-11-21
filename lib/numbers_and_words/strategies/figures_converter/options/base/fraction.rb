# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Options
        module Base
          # fraction: true reads decimals as a fraction ("zero and one tenth") instead of with a decimal point.
          # The decimal decorators and joiners read options[:fraction] directly; this class declares the option.
          class Fraction # rubocop:disable Lint/EmptyClass -- declares the option for validation only
          end
        end
      end
    end
  end
end
