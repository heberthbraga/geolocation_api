module Error
  class LoadInstance < Error::Standard
    def initialize
      super(
        title: Error::Title::PROVIDER_INSTANCE_NOT_FOUND,
        status: Error::Status::RECORD_NOT_FOUND,
        detail: Error::Message::PROVIDER_INSTANCE_NOT_FOUND_ERROR
      )
    end
  end
end