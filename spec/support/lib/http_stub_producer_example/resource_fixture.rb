module HttpStubExampleProducer

  class ResourceFixture

    def self.json(id:SecureRandom.uuid)
      { id: id, name: Faker::Lorem.word }.to_json
    end

  end

end
