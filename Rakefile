require 'bundler'
Bundler.require(:default, :development)

require 'rubocop/rake_task'
require 'rspec/core/rake_task'
require 'http_server_manager/rake/task_generators'

HttpServerManager.pid_dir = File.expand_path('../tmp/pids', __FILE__)
HttpServerManager.log_dir = File.expand_path('../tmp/logs', __FILE__)

require_relative 'lib/http_stub_example_producer/server'

desc "Removes generated artefacts"
task :clobber do
  %w{ pkg tmp }.each { |dir| rm_rf dir }
  rm Dir.glob("**/coverage.data"), force: true
  puts "Clobbered"
end

namespace :metrics do

  RuboCop::RakeTask.new(:rubocop) { |task| task.fail_on_error = true }

end

desc "Performs source code metrics analysis"
task metrics: "metrics:rubocop"

desc "Exercises unit tests"
::RSpec::Core::RakeTask.new(:unit_test) do |task|
  task.exclude_pattern = "spec/acceptance/**{,/*/**}/*_spec.rb"
end

desc "Exercises acceptance tests"
::RSpec::Core::RakeTask.new(:acceptance_test) do |task|
  task.pattern = "spec/acceptance/**{,/*/**}/*_spec.rb"
end

desc "Exercises specifications with coverage analysis"
task :coverage => "coverage:generate"

namespace :coverage do

  desc "Generates specification coverage results"
  task :generate do
    ENV["coverage"] = "enabled"
    Rake::Task[:unit_test].invoke
    Rake::Task["codeclimate-test-reporter"].invoke if ENV["CODECLIMATE_REPO_TOKEN"]
  end

  desc "Shows specification coverage results in browser"
  task :show do
    begin
      Rake::Task["coverage:generate"].invoke
    ensure
      `open tmp/coverage/index.html`
    end
  end

end

namespace :server do

  HttpServerManager::Rake::ServerTasks.new(HttpStubExampleProducer::Server.new)

end

namespace :servers do

  task :start do
    sh "docker-compose up --build --force-recreate -d"
  end

  task :stop do
    sh "docker-compose down"
  end

end

desc "Exercises acceptance tests and manages dependencies"
task acceptance: "servers:start" do
  begin
    Rake::Task["acceptance_test"].invoke
  ensure
    Rake::Task["servers:stop"].invoke
  end
end

namespace :ci do

  task :validate do
    print " Travis CI Validation ".center(80, "*") + "\n"
    result = `travis-lint #{::File.expand_path('../.travis.yml', __FILE__)}`
    puts result
    print "*" * 80+ "\n"
    raise "Travis CI validation failed" unless $?.success?
  end

end

task default: %w{ clobber metrics coverage acceptance }

task pre_commit: %w{ clobber metrics coverage:show acceptance ci:validate }
