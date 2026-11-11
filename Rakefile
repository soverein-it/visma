begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

require 'rdoc/task'

RDoc::Task.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'Visma'
  rdoc.options << '--line-numbers'
  rdoc.rdoc_files.include('README.rdoc')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

APP_RAKEFILE = File.expand_path("../test/dummy/Rakefile", __FILE__)
load 'rails/tasks/engine.rake'

namespace :visma do
  namespace :db do
    desc 'Create the dummy app databases in SQL Server and load db/visma_schema.rb (see docker-compose.yml)'
    task prepare: 'app:db:create' do
      Rake::Task['app:environment'].invoke
      envs = ENV['RAILS_ENV'] ? [ENV['RAILS_ENV']] : %w[development test]
      envs.each do |env|
        config = ActiveRecord::Base.configurations.configs_for(env_name: env, name: 'primary')
        ActiveRecord::Base.establish_connection(config)
        ActiveRecord::Base.connection.execute("IF SCHEMA_ID('KuraasAS') IS NULL EXEC('CREATE SCHEMA KuraasAS')")
        ActiveRecord::Migration.suppress_messages { load File.expand_path('db/visma_schema.rb', __dir__) }
        puts "Loaded db/visma_schema.rb into #{config.database}"
      end
    end
  end
end

Bundler::GemHelper.install_tasks

require 'rake/testtask'

Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = false
end


task default: :test
