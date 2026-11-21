# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Decorators
        module Hu
          # The integral part comes before egész when a fractional part follows ("két egész öt tized").
          class Integral < Base
            def run
              @options[:integral][:with_fraction] ? before_noun(super) : super
            end
          end
        end
      end
    end
  end
end
