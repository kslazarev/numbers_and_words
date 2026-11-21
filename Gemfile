# frozen_string_literal: true

source 'https://rubygems.org'

gemspec

# CI also tests an older i18n release with I18N_VERSION.
gem 'i18n', ENV.fetch('I18N_VERSION') unless ENV.fetch('I18N_VERSION', '').empty?

group :development do
  gem 'benchmark-ips'
  gem 'rake'
  gem 'rdoc', require: false
  if RUBY_ENGINE == 'ruby' && Gem::Version.new(RUBY_VERSION) >= Gem::Version.new('3.3')
    gem 'commonmarker', '~> 2.10', require: false
    gem 'ruby-gem-release', '~> 0.9.0', require: false
  end
end

group :test do
  gem 'rspec'
  # No lockfile is committed; lock lint tools so new cops arrive only through upgrades.
  gem 'rubocop', '1.92.3', require: false
  gem 'rubocop-performance', '1.27.0', require: false
  gem 'rubocop-rake', '0.7.1', require: false
  gem 'rubocop-rspec', '3.10.2', require: false
  gem 'simplecov', require: false
  gem 'simplecov-lcov', require: false
end
