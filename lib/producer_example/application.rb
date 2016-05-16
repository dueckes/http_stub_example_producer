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
      found_resource = @resources.find { |resource| resource.id == params["id"] }
      halt 404 unless found_resource
      halt 200, { "Content-Type" => "application/json" }, found_resource.to_json
    end

    post "/resource" do
      resource = parse_resource
      halt 400 unless resource
      @resources << resource
      halt 204
    end

    private

    def parse_resource
      ProducerExample::Resource.from_json(request.body.read)
    rescue
      nil
    end

  end

end
