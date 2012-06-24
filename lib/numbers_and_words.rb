require 'rubygems'
require 'i18n'
require 'i18n/backend/pluralization'
require 'active_support/inflector'

require 'numbers_and_words/translations_helpers'
require 'numbers_and_words/strategies'
require 'numbers_and_words/array_additions'
require 'numbers_and_words/figures_array'
require 'numbers_and_words/core_ext/integer'
require 'numbers_and_words/core_ext/array'
require 'numbers_and_words/i18n'
require 'numbers_and_words/version'

NumbersAndWords::I18n::Initialization.init
