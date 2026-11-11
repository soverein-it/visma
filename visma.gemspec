$LOAD_PATH.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'visma/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'visma'
  s.version     = Visma::VERSION
  s.authors     = ['Runar Ingebrigtsen']
  s.email       = ['runar@rin.no']
  s.homepage    = 'https://github.com/soverein-it/visma'
  s.summary     = 'Integrate Rails with Visma Global'
  s.description = 'Visma Global ERP integration for Ruby on Rails. Requires support for SQL Server 2012 and newer.'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']
  s.test_files = Dir['test/**/*']

  s.add_runtime_dependency('zeitwerk', '~> 2.4')

  # Lowest releases without known advisories: 8.0.5.2 and 8.1.4.1 (CVE-2026-126186 among others).
  s.add_dependency 'rails', '>= 8.0.5.2', '< 9',
                   '!= 8.1.0', '!= 8.1.1', '!= 8.1.2', '!= 8.1.2.1',
                   '!= 8.1.3', '!= 8.1.3.1', '!= 8.1.4'
  s.add_dependency 'activerecord-sqlserver-adapter', '>= 8.0', '< 9'
end
