class Integer
  def to_words
    to_figures_array.to_words NumbersAndWords::Strategies::Base.factory
  end

  private

  def to_figures_array
    NumbersAndWords::FiguresArray.new to_s.split(//).map(&:to_i)
  end
end
