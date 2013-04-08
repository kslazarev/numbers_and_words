module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Options
        module En
          class RemoveZero
            attr_accessor :strategy, :options

            def initialize proxy, *args, &block
              @strategy = proxy.strategy
              @options = proxy.options
            end


            def result
              active?
            end

            private

            def active?
              @options[:remove_zero]
            end
          end

          module Gb
            class RemoveZero < En::RemoveZero
              def modify_or_leave words
                words = "#{translations.union} #{words}" if fractional? && active_for_integral? && modify_for_fractional?
                words
              end

              private

              def active?
                integral? ? active_for_integral? : super
              end

              def integral?
                @strategy.options.integral?
              end

              def fractional?
                @strategy.options.fractional?
              end

              def active_for_integral?
                @options[:remove_zero] != false
              end

              def modify_for_fractional?
                @options[:fractional][:integral] == 0
              end

              def translations
                @strategy.translations
              end
            end
          end
        end
      end
    end
  end
end