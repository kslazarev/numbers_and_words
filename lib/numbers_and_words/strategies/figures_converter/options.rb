# frozen_string_literal: true

require 'concurrent/map'

require 'numbers_and_words/strategies/figures_converter/options/option'

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Options
        class Proxy
          # The option class names by locale and option, which don't change at runtime.
          CLASS_NAMES = Concurrent::Map.new

          attr_accessor :strategy, :options

          def initialize(strategy, options)
            @strategy = strategy
            @options = options
          end

          # A language's own option class, such as Options::Pl::Gender, or the option it declares in its locale
          # file; an option the language doesn't support is nil.
          def method_missing(method_name, *args, &block)
            name = proxy_class_name(method_name)
            return Object.const_get(name).new(self, args, block) if Object.const_defined?(name)

            declared = OptionsValidation.declared_options(I18n.local_language)[method_name]
            Option.new(self, name: method_name, default: declared.is_a?(::Hash) ? declared[:default] : nil) if declared
          rescue NameError
            nil
          end

          def respond_to_missing?(method_name, include_private = false)
            Object.const_defined?(proxy_class_name(method_name)) || OptionsValidation.declared_options(I18n.local_language).key?(method_name) || super
          end

          private

          def proxy_class_name(method_name)
            CLASS_NAMES.compute_if_absent(::I18n.locale) { Concurrent::Map.new }[method_name] ||=
              "#{module_name}::#{I18n.language_class_name}::#{method_name.to_s.split('_').collect(&:capitalize).join}"
          end

          def module_name
            @module_name ||= self.class.name.split('::')[0..-2].join '::'
          end
        end
      end
    end
  end
end

require 'numbers_and_words/strategies/figures_converter/options/pl/gender'
