describe HttpStubExampleProducer::Application do
  include Rack::Test::Methods

  let(:response)           { last_response }
  let(:response_body)      { response.body.to_s }
  let(:json_response_body) { JSON.parse(response_body) }

  let(:app) { described_class.new! }

  describe "GET /resource" do

    subject { get "/resource" }

    it "responds with a 200 status code" do
      subject

      expect(response.status).to eql(200)
    end

    it "responds with a content-type that is application/json" do
      subject

      expect(response.headers).to include("Content-Type" => "application/json")
    end

    context "when a resource has been added" do

      let(:resource_json) { HttpStubExampleProducer::ResourceFixture.json }

      before(:example) { post "/resource", resource_json }

      it "includes the resource in the response body" do
        subject

        expect(response_body).to include(resource_json)
      end

    end

    context "when a resource has not been added" do

      it "has a response body that is an empty array" do
        subject

        expect(json_response_body).to eql([])
      end

    end

  end

  describe "GET /resource/:id" do

    let(:id) { SecureRandom.uuid }

    subject { get "/resource/#{id}" }

    context "when the resource has been created" do

      let(:resource_json) { HttpStubExampleProducer::ResourceFixture.json(id: id) }

      before(:example) { post "/resource", resource_json }

      it "responds with a 200 status code" do
        subject

        expect(response.status).to eql(200)
      end

      it "responds with a content-type that is application/json" do
        subject

        expect(response.headers).to include("Content-Type" => "application/json")
      end

      it "has resource in the response body" do
        subject

        expect(response_body).to include(resource_json)
      end

    end

    context "when the resource has not been created" do

      it "responds with a 404 status code" do
        subject

        expect(response.status).to eql(404)
      end

    end

  end

  describe "POST /resource" do

    context "when a resource is provided" do

      subject { post "/resource", HttpStubExampleProducer::ResourceFixture.json }

      it "responds with a 204 status code" do
        subject

        expect(response.status).to eql(204)
      end

      it "responds with an empty body" do
        subject

        expect(response_body).to eql("")
      end

    end

    context "when a resource is not provided" do

      subject { post "/resource" }

      it "responds with a 400 status code" do
        subject

        expect(response.status).to eql(400)
      end

    end

  end

end
