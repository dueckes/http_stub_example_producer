require 'bundler'
Bundler.require(:development)

CodeClimate::TestReporter.start

SimpleCov.start do
  coverage_dir "tmp/coverage"

  add_filter "/spec/"

  minimum_coverage 100
  refuse_coverage_drop
end if ENV["coverage"]

require_relative '../lib/http_stub_example_producer'

RSpec.configure { |config| config.order = "random" }
