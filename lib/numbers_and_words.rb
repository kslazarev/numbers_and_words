require 'rubygems'
require 'i18n'
require 'i18n/backend/pluralization'
require 'active_support/inflector'
require 'active_support/core_ext/object'

require 'numbers_and_words/translations'
require 'numbers_and_words/strategies'
require 'numbers_and_words/helper_classes'
require 'numbers_and_words/core_ext'
require 'numbers_and_words/wrappers'
require 'numbers_and_words/i18n'
require 'numbers_and_words/version'

NumbersAndWords::I18n::Initialization.init
