describe "Example Producer Stub contract verification" do

  let(:real_producer_base_uri) { "http://localhost:3000" }
  let(:stub_producer_base_uri) { "http://localhost:5000" }

  before(:example) do
    enable_stub_verification_mode
    activate_scenario(scenario_name)
  end

  after(:example) { disable_stub_verification_mode }

  shared_examples_for "a Stub Scenario contract honoured by the Producer" do

    subject { issue_verification_request(request) }

    it "matches the response from the Real Producer" do
      response_differences = JSON.parse(subject.body)

      expect(response_differences).to eql([])
    end

    def issue_verification_request(request)
      http_options = {}
      http_options[:body] = request[:body] if request[:body]
      HTTParty.send(request[:method], "#{stub_producer_base_uri}/#{request[:path]}", http_options)
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

  def enable_stub_verification_mode
    HTTParty.post("#{stub_producer_base_uri}/http_stub/config/mode", mode: :verify, producer_url: real_producer_base_uri)
  end

  def disable_stub_verification_mode
    HTTParty.post("#{stub_producer_base_uri}/http_stub/config/mode", mode: :match)
  end

  def activate_scenario(name)
    HTTParty.post("#{stub_producer_base_uri}/http_stub/scenarios/activate", name: name)
  end

end
