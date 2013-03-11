class Array
  def to_words options = {}
    map! do |element|
      element, options = element.first, options.merge(element.last) if element.is_a?(Array)
      element.to_words options
    end
  end

  def to_figures
    NumbersAndWords::FiguresArray.new self
  end
end
