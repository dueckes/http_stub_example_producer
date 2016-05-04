describe "Producer Example Stub contract verification" do

  let(:real_producer_base_uri) { "http://localhost:3000" }
  let(:stub_producer_base_uri) { "http://localhost:3001" }
  let(:producer_base_uris)     { [ real_producer_base_uri, stub_producer_base_uri ] }

  before(:example) { activate_scenario(scenario_name) }

  shared_examples_for "a Stub Scenario contract honoured by the Producer" do

    subject { send_requests(request) }

    it "matches the response from the Real Producer" do
      responses = subject

      expect(responses[0]).to eql(responses[1])
    end

    def send_requests(options)
      http_options = {}
      http_options[:body] = options[:body] if options[:body]
      producer_base_uris.map { |base_uri| HTTParty.send(options[:method], "#{base_uri}/#{options[:path]}", http_options) }
    end

  end

  describe "Scenario: Many Resources" do

    let(:scenario_name) { "Many Resource" }
    let(:request)       { { method: :get, path: "resource" } }

    it_behaves_like "a Stub Scenario contract honoured by the Producer"

  end

  describe "Scenario: No Resources" do

    let(:scenario_name) { "No Resources" }
    let(:request)       { { method: :get, path: "resource" } }

    it_behaves_like "a Stub Scenario contract honoured by the Producer"

  end

  describe "Scenario: Create Resource Successfully" do

    let(:scenario_name) { "Create Resource Successfully" }
    let(:payload)       { { id: SecureRandom.uuid, name: Faker::Name.name }.to_json }
    let(:request)       { { method: :post, path: "resource", body: payload } }

    it_behaves_like "a Stub Scenario contract honoured by the Producer"

  end

  describe "Scenario: Create Resource Validation Error" do

    let(:scenario_name) { "Create Resource Validation Error" }
    let(:payload)       { { id: SecureRandom.uuid }.to_json }
    let(:request)       { { method: :post, path: "resource", body: payload } }

    it_behaves_like "a Stub Scenario contract honoured by the Producer"

  end

  def activate_scenario(name)
    HTTParty.post("http://localhost:3001/http_stub/scenarios/activate", name: name)
  end

end
