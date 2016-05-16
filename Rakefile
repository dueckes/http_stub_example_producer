require 'bundler'
Bundler.require(:default, :development)

require 'rubocop/rake_task'
require 'rspec/core/rake_task'
require 'http_server_manager/rake/task_generators'

require_relative 'lib/producer_example/server'

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

desc "Exercises specifications"
::RSpec::Core::RakeTask.new(:spec)

desc "Exercises specifications with coverage analysis"
task :coverage => "coverage:generate"

namespace :coverage do

  desc "Generates specification coverage results"
  task :generate do
    ENV["coverage"] = "enabled"
    Rake::Task[:spec].invoke
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

HttpServerManager.pid_dir = File.expand_path('../tmp/pids', __FILE__)
HttpServerManager.log_dir = File.expand_path('../tmp/logs', __FILE__)

namespace :server do

  HttpServerManager::Rake::ServerTasks.new(ProducerExample::Server.new)

end

task :validate do
  print " Travis CI Validation ".center(80, "*") + "\n"
  result = `travis-lint #{::File.expand_path('../.travis.yml', __FILE__)}`
  puts result
  print "*" * 80+ "\n"
  raise "Travis CI validation failed" unless $?.success?
end

task :default => %w{ clobber metrics coverage }

task :pre_commit => %w{ clobber metrics coverage:show validate }
