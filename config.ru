require_relative 'lib/producer_example'

ProducerExample::Application.instance_eval do
  set :port, 3000
  run!
end