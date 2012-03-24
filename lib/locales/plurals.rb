module NumbersAndWords
  module Locales
    module Plurals
    
      RU = lambda do |count|
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

      EN = lambda do |count| 
        1 == count ? :one : :other
      end
      
    end
  end
end

{
  :ru => { :i18n => { :plural => { :rule => NumbersAndWords::Locales::Plurals::RU }}},
  :en => { :i18n => { :plural => { :rule => NumbersAndWords::Locales::Plurals::EN }}}
}

