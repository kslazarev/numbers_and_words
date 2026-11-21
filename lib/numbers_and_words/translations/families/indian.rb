# frozen_string_literal: true

module NumbersAndWords
  module Translations
    module Families
      # Words for the Indian numbering system, see Strategies::FiguresConverter::Languages::Families::Indian.
      module Indian
        # Every number from 0 to 99.
        def ones(number)
          t(:ones)[number]
        end

        def hundreds(digit)
          t(:hundreds)[digit]
        end

        # Scale words from thousand up: thousand, lakh, crore and, where the language has them, more.
        def scales
          t(:scales)
        end

        def micro_separator
          t(:micro_separator)
        end
      end
    end
  end
end
