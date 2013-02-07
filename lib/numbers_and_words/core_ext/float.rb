class Float
  def to_words point_word = 'point'
    int, rest = to_s.split('.').map(&:to_i).map(&:to_words)
    [int, point_word, rest].join ' '
  end
end