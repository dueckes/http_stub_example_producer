module ProducerExample

  class Resource

    attr_reader :id, :name

    def self.from_json(payload)
      self.new(JSON.parse(payload).symbolize_keys) rescue nil
    end

    def initialize(id:, name:)
      @id   = id
      @name = name
    end

  end

end
