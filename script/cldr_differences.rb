# frozen_string_literal: true

# Refreshes the reviewed differences between this gem and the Unicode CLDR
# spell-out rules (see spec/cldr_comparison_spec.rb):
#
# * sets the affects: count of every rule in spec/fixtures/cldr_rules.yml;
# * rewrites spec/fixtures/cldr_exceptions.yml with the differences that remain
#   after the rules, keeping the reason of every unchanged exception and
#   marking new or changed ones "TODO", which the spec rejects;
# * lists the new differences grouped by the words they change, as candidate
#   rules, so that a reviewer can write one rule instead of many exceptions.
#
#   bundle exec ruby script/cldr_differences.rb

$LOAD_PATH.unshift File.expand_path('../lib', __dir__), File.expand_path('../spec', __dir__)

require 'numbers_and_words'
require 'support/cldr_comparison'

# Compare the readings the specs test: the 2.0 defaults, without the 1.x ones (see spec/spec_helper.rb).
NumbersAndWords::Compatibility.apply_defaults = false

HEADER = <<~YAML
  # Differences between this gem and the Unicode CLDR spell-out rules that no rule
  # in spec/fixtures/cldr_rules.yml covers (see spec/cldr_comparison_spec.rb), by
  # locale, kind and number. Each exception gives the gem's and CLDR's readings and
  # the reason the difference that remains after the rules is accepted.
  #
  # Regenerate with `bundle exec ruby script/cldr_differences.rb`, then write a rule
  # for a repeated difference or replace each TODO with a reason; differences that
  # are gem bugs are fixed instead.
YAML

results = CldrComparison.results
rules = CldrComparison.rules

# affects: counts, in file order, which is the order of the rules.
text = File.read(CldrComparison::RULES_FILE)
counts = text.scan(/\baffects: \d+/).size
abort "#{CldrComparison::RULES_FILE} has #{counts} affects: counts for #{rules.size} rules; give every rule one" unless counts == rules.size
affects = rules.map { |rule| results.count { |result| result.rules.include?(rule) } }.each
File.write(CldrComparison::RULES_FILE, text.gsub(/(?<=\baffects: )\d+/) { affects.next })

current = CldrComparison.exceptions
todo = []
exceptions = results.select(&:differs?).group_by(&:locale).to_h do |locale, by_locale|
  [locale, by_locale.group_by(&:kind).to_h do |kind, by_kind|
    [kind, by_kind.to_h do |result|
      known = current.dig(locale, kind, result.number)
      reason = known && known.values_at('gem', 'cldr') == [result.gem, result.cldr] ? known['reason'] : 'TODO'
      todo << result if reason == 'TODO'
      [result.number, { 'gem' => result.gem, 'cldr' => result.cldr, 'reason' => reason }]
    end]
  end]
end
File.write(CldrComparison::EXCEPTIONS_FILE, HEADER + exceptions.to_yaml(line_width: -1).delete_prefix("---\n"))

unused = rules.select { |rule| results.none? { |result| result.rules.include?(rule) } }
puts "#{rules.size} rules (#{unused.size} unused), #{exceptions.sum { |_, kinds| kinds.sum { |_, numbers| numbers.size } }} exceptions, #{todo.size} to review"
unused.each { |rule| puts "  unused: #{rule.name}: #{rule.reason}" }

# Each word that differs between CLDR's reading after the rules and the gem's,
# when both have the same number of words, or else the whole readings: a
# substitution repeated across numbers is a candidate rule.
candidates = Hash.new { |hash, key| hash[key] = [] }
todo.each do |result|
  cldr = result.ruled.split
  gem = result.gem.split
  pairs = cldr.size == gem.size ? cldr.zip(gem).reject { |from, to| from == to } : [[result.ruled, result.gem]]
  pairs.uniq.each { |pair| candidates[[result.locale, pair]] << result }
end
candidates.sort_by { |(locale, _), group| [locale, -group.size] }.each do |(locale, (from, to)), group|
  puts "#{locale}: #{from.inspect} => #{to.inspect} (#{group.size}: #{group.map { |result| "#{result.kind} #{result.number}" }.join(', ')})"
end
