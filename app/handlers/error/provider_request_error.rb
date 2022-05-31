module Error
  class ProviderRequestError < Error::Standard
    def initialize(title, detail, endpoint)
      super(
        title: title,
        status: Error::Status::INVALID_REQUEST,
        detail: detail,
        source: { pointer: endpoint }
      )
    end
  end
end