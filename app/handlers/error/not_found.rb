module Error
  class NotFound < Error::Standard
    def initialize
      super(
        title: Error::Title::RECORD_NOT_FOUND,
        status: Error::Status::RECORD_NOT_FOUND,
        detail: Error::Message::RECORD_NOT_FOUND_ERROR,
        source: { pointer: '/request/url/:id' }
      )
    end
  end
end
