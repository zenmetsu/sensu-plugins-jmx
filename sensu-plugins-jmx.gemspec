lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'date'
require_relative 'lib/sensu-plugins-jmx'

Gem::Specification.new do |s| # rubocop:disable Metrics/BlockLength
  s.authors                = ['Jason Westervelt']
  s.date                   = Date.today.to_s
  s.description            = 'This plugin provides native JMX
                              instrumentation for monitoring and metrics
                              collection.'
  s.email                  = '<jason.westervelt@protonmail.com>'
  s.executables            = Dir.glob('bin/**/*.rb').map { |file| File.basename(file) }
  s.files                  = Dir.glob('{bin,lib}/**/*') + %w[LICENSE README.md CHANGELOG.md]
  s.homepage               = 'https://github.com/zenmetsu/sensu-plugins-jmx'
  s.license                = 'MIT'
  s.metadata               = { 'maintainer'         => 'zenmetsu',
                               'development_status' => 'active',
                               'production_status'  => 'unstable - testing recommended',
                               'release_draft'      => 'false',
                               'release_prerelease' => 'false' }
  s.name                   = 'sensu-plugins-jmx'
  s.platform               = Gem::Platform::RUBY
  s.post_install_message   = 'You can use the embedded Ruby by setting EMBEDDED_RUBY=true in /etc/default/sensu'
  s.require_paths          = ['lib']
  s.required_ruby_version  = '>= 2.3'
  s.summary                = 'Sensu plugins for JMX'
  s.test_files             = s.files.grep(%r{^(test|spec|features)/})
  s.version                = SensuPluginsJMX::Version::VER_STRING

  s.add_runtime_dependency 'english',      '0.6.3'
  s.add_runtime_dependency 'jmx',          '~> 1.0'
  s.add_runtime_dependency 'jruby-jars',   '~> 9.2'
  s.add_runtime_dependency 'sensu-plugin', '~> 4.0'

  s.add_development_dependency 'bundler',                   '~> 1.7'
  s.add_development_dependency 'codeclimate-test-reporter', '~> 0.4'
  s.add_development_dependency 'github-markup',             '~> 3.0'
  s.add_development_dependency 'pry',                       '~> 0.10'
  s.add_development_dependency 'rake',                      '~> 12.3'
  s.add_development_dependency 'redcarpet',                 '~> 3.2'
  s.add_development_dependency 'rspec',                     '~> 3.4'
  s.add_development_dependency 'rubocop',                   '~> 0.51.0'
  s.add_development_dependency 'yard',                      '~> 0.9.20'
end
