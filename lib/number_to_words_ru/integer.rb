class Integer
  def to_words
    to_figures_array.to_words
  end

  private

  def to_figures_array
    FiguresArray.new(to_s.split(//).collect { |s| s.to_i })
  end
end
