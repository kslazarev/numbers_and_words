# frozen_string_literal: true

require 'spec_helper'
require 'numbers_and_words/cli'
require 'open3'
require 'rbconfig'
require 'stringio'

describe NumbersAndWords::CLI do
  def run_cli(*argv, stdin: '')
    stdout = StringIO.new
    stderr = StringIO.new
    status = described_class.start(argv, stdin: StringIO.new(stdin), stdout:, stderr:)
    [status, stdout.string, stderr.string]
  end

  around { |example| I18n.with_locale(:en) { example.run } }

  it 'spells out integers and decimals in English by default, one per line' do
    expect(run_cli('42', '1.5')).to eq([0, "forty-two\none point five\n", ''])
  end

  it 'reads whitespace-separated numbers from standard input when no arguments are given' do
    expect(run_cli(stdin: "7\n 21\t3\n")).to eq([0, "seven\ntwenty-one\nthree\n", ''])
  end

  it 'uses the selected locale without changing the caller locale' do
    expect(run_cli('-l', 'fr', '21')).to eq([0, "vingt-et-un\n", ''])
    expect(run_cli('--locale', 'en-GB', '101')).to eq([0, "one hundred and one\n", ''])
    expect(I18n.locale).to eq(:en)
  end

  it 'passes flags as to_words options' do
    expect(run_cli('--ordinal', '21')).to eq([0, "twenty-first\n", ''])
    expect(run_cli('--remove-hyphen', '21')).to eq([0, "twenty one\n", ''])
    expect(run_cli('-l', 'es', '--gender', 'female', '--no-apocopated', '1')).to eq([0, "una\n", ''])
    expect(run_cli('-l', 'es', '--gender=female', '21')).to eq([0, "veintiuna\n", ''])
    expect(run_cli('-l', 'en-GB', '--no-hundreds-with-union', '101')).to eq([0, "one hundred one\n", ''])
  end

  it 'passes value options with their types' do
    expect(run_cli('--precision', '2', '0.5')).to eq([0, "zero point five zero\n", ''])
    expect(run_cli('--micro-separator', 'plus', '1.5')).to eq([0, "one plus five\n", ''])
  end

  it 'has a flag for every option any language accepts' do
    _, help, = run_cli('--help')
    options = NumbersAndWords::I18n.languages.flat_map { |locale| NumbersAndWords::OptionsValidation.supported_options(locale).keys }.uniq
    flags = options.map { |name| name.to_s.tr('_', '-') }
    expect(flags.reject { |flag| help.include?("--#{flag} ") || help.include?("--[no-]#{flag} ") }).to eq([])
    expect(options - described_class::DESCRIPTIONS.keys).to eq([])
  end

  it 'accepts an explicit plus sign' do
    expect(run_cli('+3')).to eq([0, "three\n", ''])
  end

  it 'prints the version and help' do
    expect(run_cli('--version')).to eq([0, "#{NumbersAndWords::VERSION}\n", ''])
    status, stdout, = run_cli('-h')
    expect(status).to eq(0)
    expect(stdout).to include('Usage: to_words [options] [NUMBER...]', '--locale LOCALE', '--[no-]ordinal', '--gender VALUE', 'Spell ordinal numbers (cs, da, de, en, en-GB, es, et, fr, fr-CH, hu, hy, it, ka, kz, lt, lv, nl, pl, pt, pt-BR, ru, se, th, tr, ua, vi, zh)')
  end

  {
    %w[abc] => 'not a number: "abc"',
    %w[1e5] => 'not a number: "1e5"',
    %w[1.] => 'not a number: "1."',
    %w[-- -5] => 'negative numbers are not supported: -5',
    %w[-l xx 1] => ':xx is not a valid locale',
    %w[-l vi --gender female 1] => 'unsupported option :gender for locale :vi; supported: :micro_separator, :ordinal, :precision, :remove_zero',
    %w[-l es --gender neuter 1] => 'unsupported value "neuter" for option :gender in locale :es; supported: :male, :female',
    %w[--precision x 1] => 'invalid argument: --precision x',
    %w[--gender] => 'missing argument: --gender',
    %w[--bogus 1] => 'invalid option: --bogus',
    %w[--locale] => 'missing argument: --locale'
  }.each do |argv, message|
    it "rejects #{argv.join(' ')} with a clear error and status 1" do
      status, stdout, stderr = run_cli(*argv)
      expect([status, stdout]).to eq([1, ''])
      expect(stderr).to start_with("to_words: #{message}")
      expect(stderr).to include('Usage: to_words')
    end
  end

  it 'rejects empty standard input' do
    status, stdout, stderr = run_cli(stdin: " \n")
    expect([status, stdout]).to eq([1, ''])
    expect(stderr).to start_with('to_words: no numbers given')
  end

  it 'does not convert any number when one argument is invalid' do
    expect(run_cli('1', 'two')).to eq([1, '', "to_words: not a number: \"two\"\nUsage: to_words [options] [NUMBER...]\n"])
  end

  describe 'executable' do
    let(:root) { File.expand_path('../..', __dir__) }

    def execute(*argv, stdin: '')
      Open3.capture3(RbConfig.ruby, '-I', File.join(root, 'lib'), File.join(root, 'bin', 'to_words'), *argv, stdin_data: stdin)
    end

    it 'converts arguments and standard input in a real process' do
      stdout, stderr, status = execute('-l', 'ru', '2000')
      expect([stdout, stderr, status.exitstatus]).to eq(["две тысячи\n", '', 0])
      stdout, _, status = execute(stdin: '42')
      expect([stdout, status.exitstatus]).to eq(["forty-two\n", 0])
    end

    it 'exits non-zero for invalid input in a real process' do
      stdout, stderr, status = execute('nope')
      expect([stdout, status.exitstatus]).to eq(['', 1])
      expect(stderr).to include('not a number: "nope"')
    end
  end
end
