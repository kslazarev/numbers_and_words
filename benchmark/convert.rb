# frozen_string_literal: true

require 'benchmark/ips'
$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'numbers_and_words'

cases = {
  'en/small' => [:en, 42, {}],
  'en/large' => [:en, 1_174_315_119, {}],
  'ru/large' => [:ru, 1_174_315_119, {}],
  'it/fraction' => [:it, 21.77, {}],
  'en-GB/fraction' => [:'en-GB', 21.77, {}],
  'pt-BR/ordinal' => [:'pt-BR', 42, { ordinal: true }],
  'en/array' => [:en, [1, 22, 333, 4444, 55_555], {}]
}
iterations = Integer(ENV.fetch('BENCHMARK_ITERATIONS', '1000'))
abort 'BENCHMARK_ITERATIONS must be positive' unless iterations.positive?

puts "#{RUBY_DESCRIPTION}; I18n #{I18n::VERSION}"
puts "Allocations per conversion (#{iterations} warmed iterations):"
cases.each do |name, (locale, number, options)|
  I18n.with_locale(locale) do
    number.to_words(options)
    GC.start
    before = GC.stat(:total_allocated_objects)
    iterations.times { number.to_words(options) }
    allocated = (GC.stat(:total_allocated_objects) - before).fdiv(iterations)
    puts format('%<name>-20s %<allocated>10.1f objects', name:, allocated:)
  end
end

Benchmark.ips do |report|
  report.config(time: Float(ENV.fetch('BENCHMARK_TIME', '3')), warmup: Float(ENV.fetch('BENCHMARK_WARMUP', '1')))
  cases.each do |name, (locale, number, options)|
    report.report(name) { I18n.with_locale(locale) { number.to_words(options) } }
  end
end
