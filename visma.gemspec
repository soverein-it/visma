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
  s.summary     = 'Integrate Rails 6 with Visma Global'
  s.description = 'Visma Global ERP integration for Ruby on Rails. Requires support for SQL Server 2012 and newer.'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']
  s.test_files = Dir['test/**/*']

  s.add_runtime_dependency('zeitwerk', '~> 2.4')

  s.add_dependency "rails", "~> 6.0"
  s.add_dependency 'activerecord-sqlserver-adapter', '~> 6.1'
end
