module Error
  class Forbidden < Error::Standard
    def initialize
      super(
        title: Error::Title::FORBIDDEN,
        status: Error::Status::FORBIDDEN,
        detail: Error::Message::UNAUTHOROZED_PUNDIT_ERROR
      )
    end
  end
end
