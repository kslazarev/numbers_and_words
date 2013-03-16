module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        module Families
          module Cyrillic

            private

            def gender
              case @current_capacity.to_i
              when 1
                :female
              when 0
                options.gender.result
              else
                :male
              end
            end

            [:ones, :tens_with_ones].each do |method_name|
              define_method(method_name) {
                super({:gender => gender})
              }
            end

            def megs
              super({:number => @figures.number_in_capacity(@current_capacity)})
            end
          end
        end
      end
    end
  end
end
