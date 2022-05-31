module Error
  class IncorrectCredentials < Error::Standard
    def initialize
      super(
        title: Error::Title::INCORRECT_CREDENTIALS,
        status: Error::Status::INCORRECT_CREDENTIALS,
        detail: Error::Message::INCORRECT_CREDENTIALS_ERROR
      )
    end
  end
end
