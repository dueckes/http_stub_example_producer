require_relative 'lib/http_stub_example_producer'

HttpStubExampleProducer::Application.instance_eval do
  set :bind, "0.0.0.0"
  set :port, 3000
  run!
end
