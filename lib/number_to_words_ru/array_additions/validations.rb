module ArrayAdditions
  module Validations
    def validate_figure_array!
      self.each do |element|
        if !element.kind_of?(Integer)
          raise "Array is not figure's: '#{element}' must be figure"
        end
      end
    end
  end
end
