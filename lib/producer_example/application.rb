module ProducerExample

  class Application < Sinatra::Base

    def initialize
      super
      @resources = []
    end

    get "/resource" do
      halt 200, { "Content-Type" => "application/json" }, @resources.to_json
    end

    get "/resource/:id" do
      resource = @resources.find { |resource| resource.id == params["id"] }
      halt 404 unless resource
      halt 200, { "Content-Type" => "application/json" }, resource.to_json
    end

    post "/resource" do
      resource = ProducerExample::Resource.from_json(request.body.read) rescue nil
      halt 400 unless resource
      @resources << resource
      halt 204
    end

  end

end
