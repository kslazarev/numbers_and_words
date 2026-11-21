# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        # Hindi (hi) uses the Indian numbering system with अरब (10^9) and खरब (10^11), and ordinals that agree in gender.
        class Hi < Base
          include Families::Indian

          private

          def ordinal_forms
            @translations.t(:ordinals)[@options.gender.result]
          end
        end
      end
    end
  end
end
