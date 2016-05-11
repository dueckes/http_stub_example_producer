require_relative 'lib/producer_example'

ProducerExample::Application.instance_eval do
  set :bind, "0.0.0.0"
  set :port, 3000
  run!
end
