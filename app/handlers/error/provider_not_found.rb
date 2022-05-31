module Error
  class ProviderNotFound < Error::Standard
    def initialize
      super(
        title: Error::Title::PROVIDER_NOT_FOUND,
        status: Error::Status::RECORD_NOT_FOUND,
        detail: Error::Message::PROVIDER_NOT_FOUND_ERROR
      )
    end
  end
end