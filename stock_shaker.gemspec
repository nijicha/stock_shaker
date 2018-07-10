# frozen_string_literal: true

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'stock_shaker/version'

Gem::Specification.new do |spec|
  spec.name = 'stock_shaker'
  spec.version = StockShaker::VERSION
  spec.platform = Gem::Platform::RUBY
  spec.required_ruby_version = '>= 2.2.0'
  spec.authors = ['Nathakorn Chaninthanadecha']
  spec.email = ['nathakorn.tonch@gmail.com']
  spec.license = 'MIT'
  spec.summary = <<-SUMMARY
    Kick off API for eCommerce in Thailand.
  SUMMARY
  spec.description = <<-DESCRIPTION
    This gems inspired from Official Lazada Open Platform Gems.
    This will kick off an APIs of Lazada, Shopee and JD Central.
  DESCRIPTION

  spec.metadata = {
    'homepage_uri' => 'https://rubygems.org/gems/stock_shaker',
    'changelog_uri' => 'https://github.com/nijicha/stock_shaker/blob/master/CHANGELOG.md',
    'source_code_uri' => 'https://github.com/nijicha/stock_shaker',
    'bug_tracker_uri' => 'https://github.com/nijicha/stock_shaker/issues'
  }

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'activesupport', '~> 5.0'
  spec.add_runtime_dependency 'rest-client', '~> 2.0', '>= 2.0.2'

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'nokogiri', '~> 1.8', '>= 1.8.4'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0.57.2'
end
