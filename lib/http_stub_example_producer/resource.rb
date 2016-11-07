module HttpStubExampleProducer

  class Resource

    attr_reader :id, :name

    def self.from_json(payload)
      self.new(JSON.parse(payload).symbolize_keys)
    rescue
      nil
    end

    def initialize(id:, name:)
      @id   = id
      @name = name
    end

    def to_json(options=nil)
      { id: @id, name: @name }.to_json(options)
    end

  end

end
