# frozen_string_literal: true

require 'spec_helper'
require 'support/cldr_comparison'

describe CldrComparison::Rule do
  def rule(definition)
    described_class.new('xx', 0, { 'reason' => 'test', 'affects' => 1 }.merge(definition))
  end

  it 'replaces whole words only' do
    expect(rule('replace' => { 'tre' => 'three' }).apply('tre trenta ventitre')).to eq('three trenta ventitre')
  end

  it 'replaces parts of words' do
    expect(rule('replace_parts' => { 'tré' => 'tre' }).apply('ventitrémila')).to eq('ventitremila')
  end

  it 'drops the implicit one at the start of the reading and after a scale word only' do
    drop = rule('drop_one' => { 'one' => ['bir'], 'before' => %w[yüz min] })
    expect(drop.apply('bir min bir yüz')).to eq('min yüz')
    expect(drop.apply('iyirmi bir min')).to eq('iyirmi bir min')
  end

  it 'adds a prefix only before the listed words' do
    prefix = rule('prefix' => 'et ', 'before' => ['hundrede'])
    expect(prefix.apply('hundrede og en')).to eq('et hundrede og en')
    expect(prefix.apply('hundredede')).to eq('hundredede')
  end

  it 'splits and joins at the listed parts' do
    expect(rule('split_before' => ['hundrede']).apply('tohundrede')).to eq('to hundrede')
    expect(rule('join_after' => ['tusen']).apply('ettusen ett miljoner tre')).to eq('ettusenett miljoner tre')
    expect(rule('join_before' => ['tisíc']).apply('dve tisíc sto')).to eq('dvetisíc sto')
  end

  it 'hyphenates except next to the listed words' do
    expect(rule('hyphenate' => ['millions']).apply('cent vingt millions quatre cent')).to eq('cent-vingt millions quatre-cent')
  end

  it 'scopes a rule by kind and number' do
    scoped = rule('replace' => { 'a' => 'b' }, 'kinds' => ['ordinal'], 'above' => 10, 'below' => 100)
    expect([scoped.applies?('ordinal', 11), scoped.applies?('ordinal', 10), scoped.applies?('ordinal', 100), scoped.applies?('cardinal', 11)])
      .to eq([true, false, false, false])
  end

  it 'reports malformed definitions' do
    expect(rule('replace' => {}, 'join_after' => [], 'before' => ['x'], 'ticket' => '19918', 'affects' => nil, 'colour' => 1).problems).to contain_exactly(
      'needs exactly one operation', 'has unknown keys colour', 'has before: without prefix:', 'needs an affects: count',
      'has a ticket: that is not a CLDR Jira key such as CLDR-19918'
    )
    expect(rule('replace' => {}, 'reason' => 'TODO').problems).to eq(['needs a reason'])
  end
end
