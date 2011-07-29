ru_rule = lambda do |count|
  case count
  when Integer
    case
    when 1 == count
      :one
    when (2..4).include?(count)
      :few
    else
      :many
    end
  else
    :other
  end
end

en_rule = lambda{|count| 1 == count ? :one : :other}

{
  :ru => {:i18n => {:plural => {:rule => ru_rule}}},
  :en => {:i18n => {:plural => {:rule => en_rule}}}
}
