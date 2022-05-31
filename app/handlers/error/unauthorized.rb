module Error
  class Unauthorized < Error::Standard
    def initialize
      super(
        title: Error::Title::UNAUTHORIZED,
        status: Error::Status::UNAUTHORIZED,
        detail: Error::Message::UNAUTHOROZED_ERROR
      )
    end
  end
end