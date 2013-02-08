module NumbersAndWords
  module ArrayAdditions
    module Validations
      def validate_figure_array!
        raise "Figures may contain only 1 `.` (#{count '.'} found)." if count(".") > 1
      end
    end
  end
end
