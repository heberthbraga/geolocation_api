module Error
  class AuthenticationFailed < Error::Standard
    def initialize
      super(
        title: Error::Title::AUTHENTICATION_FAILED,
        status: Error::Status::AUTHENTICATION_FAILED,
        detail: Error::Message::AUTHENTICATION_FAILED_ERROR
      )
    end
  end
end
