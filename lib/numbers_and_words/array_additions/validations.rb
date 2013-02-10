module NumbersAndWords
  module ArrayAdditions
    module Validations
      VALID_CHARACTERS = ("0".."9").to_a.push(".").freeze

      def validate_figure_array! options = {}
        if invalid_characters.any?
          invalid = invalid_characters.uniq.join ', '
          raise "Figures may contain only numbers and `.` (invalid characters: #{invalid})."
        end
        raise "Figures may contain only 1 `.` (#{count '.'} found)." if count(".") > 1
        raise "Ordinal figures may not contain a `.`." if options[:ordinal] && count(".") > 0
      end

      def invalid_characters
        reject { |character| VALID_CHARACTERS.include? character }
      end
    end
  end
end
