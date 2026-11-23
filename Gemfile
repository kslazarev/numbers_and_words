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
  # Markdown, prose and YAML lint; rubocop-prose and rubocop-yaml need Ruby 3.2, and Lint runs on the latest Ruby.
  if Gem::Version.new(RUBY_VERSION) >= Gem::Version.new('3.2')
    gem 'rubocop-md', '3.0.0', require: false
    gem 'rubocop-prose', '0.2.0', require: false
    gem 'rubocop-yaml', '0.1.0', require: false
  end
  gem 'simplecov', require: false
  gem 'simplecov-lcov', require: false
  # Unicode CLDR spell-out rules for spec/cldr_comparison_spec.rb, pinned because new CLDR data changes the reviewed
  # differences in spec/fixtures/cldr_differences.yml; twitter_cldr needs bigdecimal but doesn't declare it.
  gem 'bigdecimal', require: false
  gem 'twitter_cldr', '6.14.0', require: false
end
