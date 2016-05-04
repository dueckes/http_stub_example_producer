module ProducerExample

  class Server < HttpServerManager::Server

    def initialize
      super(name: :producer_example, host: "localhost", port: 3000)
    end

    def start_command
      "rackup"
    end

  end

end
