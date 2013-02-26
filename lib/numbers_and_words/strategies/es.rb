module NumbersAndWords
  module Strategies
    class Es < Base
      include Families::Latin
      include NumbersAndWords::TranslationsHelpers::Es

      def hundreds_number_to_words
        is_hundred = figures[1,2]==[0,1] && simple_number_to_words.empty?
        simple_number_to_words + [translation_hundreds( figures.hundreds, is_hundred )]
      end

      def hundreds_number_to_words_old
        simple_number_to_words + [translation_hundreds( figures.hundreds, simple_number_to_words.empty? )]
      end

      def capacity_iteration capacity
        words = []
        capacity_words = words_in_capacity( capacity )
        t_ones_1 = t(:ones)[1]

        words.push( translation_megs( capacity, capacity_words == [t_ones_1] )) unless capacity_words.empty?

        if capacity > 0 
          # eg 1000000 should be "un millon" not "uno millon"
          #    501000 should be "quinientos un mil" not "quinientos uno mil"
          # so we replace "uno" with "un" throughout
          t_one = t(:one)
          capacity_words = capacity_words.map{|word| word.gsub( t_ones_1, t_one ) }
        end

        words + capacity_words
      end

    end
    
  end

end
