module Error
  class MissingProviderConfiguration < Error::Standard
    attr_reader :message

    def initialize(message=nil)
      @message = message
      super(
        title: Error::Title::MISSING_PROVIDER_CONFIGURATION,
        status: Error::Status::MISSING_PROVIDER_CONFIGURATION,
        detail: @message.present? ? @message : Error::Message::MISSING_PROVIDER_CONFIGURATION_ERROR
      )
    end
  end
end