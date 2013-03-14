module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        class Base
          include Languages::Families::Base

          attr_accessor :strategy, :figures, :translations, :strings, :options

          def self.factory strategy
            language_class_name.modulize(name).constantize.new strategy
          end

          def self.language_class_name
            ::I18n.locale.to_s.titleize.gsub(' ', '::')
          end

          def initialize strategy
            @strategy = strategy
            @figures = strategy.figures
            @translations = strategy.translations
            @options = strategy.options
          end

          def words
            @strings = strings_logic
            @strings.empty? && zero || print_format
          end

          #def support_fractional_options?
          #  support? Extensions::Options::Fractional
          #end
          #
          #def support? checking_module
          #  self.class.ancestors.include? checking_module
          #end

          def print_words
            strings.reverse.join ' '
          end

          def print_format
            print_words
          end
        end
      end
    end
  end
end
