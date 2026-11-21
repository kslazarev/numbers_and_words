# frozen_string_literal: true

require 'spec_helper'
require 'support/cldr_comparison'

# Converts integers with this gem and with the Unicode CLDR spell-out rules
# (via twitter_cldr), applies the reviewed rules of spec/fixtures/cldr_rules.yml
# to CLDR's reading, and fails on any remaining difference that isn't an
# exception in spec/fixtures/cldr_exceptions.yml, on an exception that no longer
# differs, and on a rule whose affects: count changed. See
# CldrComparison::LOCALES for the rule set compared per locale.
describe CldrComparison do
  let(:exceptions) { described_class.exceptions }
  let(:refresh) { 'Run `bundle exec ruby script/cldr_differences.rb` and review' }

  def describe_result(result)
    after_rules = " (#{result.ruled.inspect} after #{result.rules.map(&:name).join(', ')})" unless result.rules.empty?
    "#{result.locale} #{result.kind} #{result.number}: gem #{result.gem.inspect}, CLDR #{result.cldr.inspect}#{after_rules}"
  end

  CldrComparison::LOCALES.each do |locale, config|
    config[:kinds].each do |kind, comparison|
      it "#{locale} #{kind} matches CLDR #{config[:cldr]} #{comparison.rule_set}" do
        results = described_class.results.select { |result| result.locale == locale.to_s && result.kind == kind }
        allowed = exceptions.dig(locale.to_s, kind) || {}
        excepted = ->(result) { allowed[result.number]&.values_at('gem', 'cldr') == [result.gem, result.cldr] }

        unexplained = results.select(&:differs?).reject(&excepted)
        stale = allowed.reject { |number, _| results.any? { |result| result.number == number && result.differs? && excepted.call(result) } }

        messages = unexplained.map { |result| describe_result(result) }
        messages += stale.map { |number, entry| "#{locale} #{kind} #{number}: stale exception (gem #{entry['gem'].inspect}, CLDR #{entry['cldr'].inspect})" }
        expect(messages).to be_empty, "#{refresh}:\n#{messages.join("\n")}"
      end
    end
  end

  it 'has rules that change only readings that differ from the gem' do
    broken = described_class.results.select { |result| result.gem == result.cldr && result.ruled != result.cldr }
    expect(broken.map { |result| describe_result(result) }).to be_empty
  end

  it 'has well-formed rules for compared locales and kinds' do
    problems = described_class.rules.flat_map do |rule|
      locale = rule.locale.delete_prefix('* ')
      kinds = CldrComparison::LOCALES.dig(locale.to_sym, :kinds)&.keys
      next ["#{rule.name}: unknown locale"] unless kinds

      unknown = Array(rule.kinds) - kinds
      (rule.problems + (unknown.empty? ? [] : ["unknown kinds #{unknown.join(', ')}"])).map { |problem| "#{rule.name}: #{problem}" }
    end
    expect(problems).to be_empty
  end

  it 'has rules that each change the number of comparisons they declare' do
    changed = described_class.rules.filter_map do |rule|
      count = described_class.results.count { |result| result.rules.include?(rule) }
      "#{rule.name} (#{rule.reason}): affects #{count}, not #{rule.affects}" unless count == rule.affects && count.positive?
    end
    expect(changed).to be_empty, "#{refresh}; a rule that affects nothing is stale:\n#{changed.join("\n")}"
  end

  it 'gives a reason for every exception' do
    missing = exceptions.flat_map do |locale, kinds|
      kinds.flat_map do |kind, numbers|
        numbers.filter_map { |number, entry| "#{locale} #{kind} #{number}" if entry['reason'].to_s.strip.empty? || entry['reason'] == 'TODO' }
      end
    end
    expect(missing).to be_empty
  end

  it 'has exceptions only for compared locales and kinds' do
    unknown = exceptions.flat_map do |locale, kinds|
      kinds.keys.reject { |kind| CldrComparison::LOCALES.dig(locale.to_sym, :kinds, kind) }.map { |kind| "#{locale} #{kind}" }
    end
    expect(unknown).to be_empty
  end

  it 'compares or explicitly skips every bundled locale' do
    bundled = NumbersAndWords::I18n.languages.map(&:to_sym)
    covered = CldrComparison::LOCALES.keys + CldrComparison::SKIPPED.keys
    expect(covered).to match_array(bundled)
  end
end
