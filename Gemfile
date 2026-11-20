# frozen_string_literal: true

source 'https://rubygems.org'

gemspec

group :development do
  gem 'benchmark-ips', '~> 2.15'
  gem 'rake', '~> 13'
  if RUBY_ENGINE == 'ruby' && Gem::Version.new(RUBY_VERSION) >= Gem::Version.new('3.3')
    gem 'commonmarker', '~> 2.10', require: false
    gem 'ruby-gem-release', '~> 0.9.0', require: false
  end
end

group :test do
  gem 'coveralls', require: false
  gem 'rspec', '~> 3'
  gem 'rubocop', '~> 1.78.0', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rake', require: false
  gem 'rubocop-rspec', require: false
end
