class Float
  def to_words options = {}
    NumbersAndWords::Wrappers::Float.new(self).to_words options
    #options[:exponential] = true if exponential?
    #as_integer_pair.to_words options
  end

  #private
  #
  #def as_integer_pair
  #  FloatAsIntegerPair.new [parts.first.to_i, parts.last.to_i]
  #end
  #
  #def parts
  #  to_s.split '.'
  #end
  #
  #def exponential?
  #  to_s =~ /[eE]{1}\+/
  #end
end
