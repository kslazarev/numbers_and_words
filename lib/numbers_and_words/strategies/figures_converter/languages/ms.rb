# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        # Malay counts like Indonesian: sebelas, seratus, seribu, satu juta.
        class Ms < Id
          LANGUAGE = 'Malay'
        end
      end
    end
  end
end
