module Error
  class JsonParser < Error::Standard
    def initialize(message)
      super(
        title: Error::Title::JSON_PARSER,
        status: Error::Status::JSON_PARSER,
        detail: message
      )
    end
  end
end