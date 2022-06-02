module Error
  class ProviderRequestError < Error::Standard
    def initialize(response, endpoint)
      super(
        title: Error::Title::PROVIDER_REPONSE_ERROR,
        status: Error::Status::INVALID_REQUEST,
        detail: response,
        source: { pointer: endpoint }
      )
    end
  end
end