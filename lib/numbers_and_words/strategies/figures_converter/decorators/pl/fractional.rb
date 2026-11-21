# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Decorators
        module Pl
          class Fractional < Cs::Fractional
            def run(&)
              raise Translations::Families::Base.decimal_range_error(48) if @options[:fractional][:length].to_i > 48

              super
            end
          end
        end
      end
    end
  end
end
