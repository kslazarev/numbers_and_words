# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Options
        module El
          # Greek counts in the neuter form (ένα, τρία, τέσσερα), so the gender defaults to neuter.
          class Gender < Base::Gender
            VALUES = %i[male female neuter].freeze

            def result
              @options[:gender] ? @options[:gender].to_sym : :neuter
            end
          end
        end
      end
    end
  end
end
