# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        # Urdu (ur) uses the Indian numbering system with ارب (10^9) and کھرب (10^11), and ordinals that agree in gender. Words are in logical order, without bidirectional control characters.
        class Ur < Base
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
