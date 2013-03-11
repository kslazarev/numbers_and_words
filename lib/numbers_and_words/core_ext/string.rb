class String
  def modulize parent_class_name
    (parent_class_name.split('::')[0..-2] << self).join '::'
  end
end