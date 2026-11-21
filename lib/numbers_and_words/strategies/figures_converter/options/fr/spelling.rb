# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Options
        module Fr
          # spelling: :reformed (the default) follows the 1990 spelling reform, hyphenating every
          # numeral in a compound number; spelling: :traditional keeps the earlier spelling.
          class Spelling
            VALUES = %i[reformed traditional].freeze

            def initialize(proxy, *_args)
              @options = proxy.options
            end

            def traditional?
              @options[:spelling]&.to_sym == :traditional
            end
          end
        end
      end
    end
  end
end
