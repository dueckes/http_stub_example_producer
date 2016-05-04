describe ProducerExample::Resource do

  let(:id)      { SecureRandom.uuid }
  let(:name)    { Faker::Name.name }

  let(:resource) { described_class.new(name: name, id: id) }

  describe "::from_json" do

    subject { described_class.from_json(payload) }

    context "when the payload is valid JSON" do

      let(:payload) { { id: id, name: name }.to_json }

      context "it returns a resource" do

        it "has the provided id" do
          expect(subject.id).to eql(id)
        end

        it "has the provided name" do
          expect(subject.name).to eql(name)
        end

      end

    end

    context "when the payload is invalid JSON" do

      let(:payload) { "invalid JSON" }

      it "returns nil" do
        expect(subject).to be(nil)
      end

    end

  end

  %i{ id name }.each do |attribute_name|

    describe "##{attribute_name}" do

      it "returns the provided value" do
        expect(resource.send(attribute_name)).to eql(self.send(attribute_name))
      end

    end

  end

end
