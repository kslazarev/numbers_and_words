# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        # Bengali (bn) uses the Indian numbering system up to কোটি (10^7), and ordinals without gender.
        class Bn < Base
          include Families::Indian

          private

          def ordinal_forms
            @translations.t(:ordinals)
          end
        end
      end
    end
  end
end
