module Error
  class ReadTimeout < Error::Standard
    def initialize(endpoint)
      super(
        title: Error::Title::READ_TIMEOUT_ERROR,
        status: Error::Status::TIMEOUT,
        detail: Error::Message::READ_TIMEOUT_ERROR,
        source: { pointer: endpoint }
      )
    end
  end
end