# frozen_string_literal: true

require 'spec_helper'

if RUBY_ENGINE == 'ruby' && Gem::Version.new(RUBY_VERSION) >= Gem::Version.new('3.3')
  require 'ruby-gem-release/rspec'
  require 'rubygems/package'

  describe 'Release workflow' do
    include RubyGemRelease::RSpec

    it 'releases the gemspec version and prepares the next development iteration' do
      skip 'ruby-gem-release 0.9.0 subprocess fixtures require POSIX PATH handling' if Gem.win_platform?
      skip 'Release tooling is validated on stable Ruby, not development snapshots' if RUBY_PATCHLEVEL.negative?

      with_release_project do |project|
        project.copy_files(
          path: File.expand_path('..', __dir__),
          files: %w[numbers_and_words.gemspec CHANGELOG.md README.md LICENSE.txt .gitignore tasks/*.rb bin/* lib/**/*]
        )
        project.configure_workflow(require: 'tasks/release', builder: 'NumbersAndWordsRelease.workflow')
        project.commit!

        project.release!(version: '1.2.3', test_task: 'build')

        expect(project.remote_file('v1.2.3', 'lib/numbers_and_words/version.rb')).to include("VERSION = '1.2.3'")
        expect(project.remote_file('v1.2.3', 'CHANGELOG.md')).to match(%r{## 1\.2\.3 \(\d{4}/\d{2}/\d{2}\)})
        expect(project.remote_file('master', 'lib/numbers_and_words/version.rb')).to include("VERSION = '1.2.4'")
        notes = project.remote_file('master', 'CHANGELOG.md')
        expect(notes).to include('## 1.2.4 (Next)', "### Features\n\n  * Your contribution here.", "### Bugs\n\n  * Your contribution here.")

        directory = project.environment.fetch('RELEASE_DATA_DIR')
        archive = File.join(directory, 'release.gem')
        expect(Gem::Package.new(archive).spec.version.to_s).to eq('1.2.3')
        %w[registry hosting].each do |destination|
          expect(File.binread(File.join(directory, destination, '1.2.3.gem'))).to eq(File.binread(archive))
        end
        expect(project.git('status', '--porcelain')).to eq('')
        expect { project.release! }.to raise_error(/Nothing to release/)
        expect(project.git('ls-remote', '--tags', 'origin')).not_to include('refs/tags/v1.2.4')
      end
    end

    it 'drops changelog sections without notes from a release' do
      skip 'ruby-gem-release 0.9.0 subprocess fixtures require POSIX PATH handling' if Gem.win_platform?
      skip 'Release tooling is validated on stable Ruby, not development snapshots' if RUBY_PATCHLEVEL.negative?

      with_release_project do |project|
        project.copy_files(
          path: File.expand_path('..', __dir__),
          files: %w[numbers_and_words.gemspec README.md LICENSE.txt .gitignore tasks/*.rb bin/* lib/**/*]
        )
        project.write('CHANGELOG.md', <<~MARKDOWN)
          ## 1.0.4 (Next)

          ### Features
            * Add a feature.
            * Your contribution here.

          ### Bugs
            * Your contribution here.

          ## 1.0.3 (Dec 23, 2025)

          ### Features
            * Earlier feature.
        MARKDOWN
        project.configure_workflow(require: 'tasks/release', builder: 'NumbersAndWordsRelease.workflow')
        project.commit!

        project.release!(version: '1.2.3', test_task: 'build')

        released = project.remote_file('v1.2.3', 'CHANGELOG.md')
        section = released[/^## 1\.2\.3 .*?(?=^## 1\.0\.3)/m]
        expect(section).to include("### Features\n  * Add a feature.")
        expect(section).not_to include('### Bugs', 'Your contribution here.')
        notes = project.remote_file('master', 'CHANGELOG.md')
        expect(notes).to include("## 1.2.4 (Next)\n\n### Features\n\n  * Your contribution here.\n\n### Bugs\n\n  * Your contribution here.")
      end
    end
  end
end
