module Error
  class ParameterMissing < Error::Standard
    def initialize
      super(
        title: Error::Title::PARAMETER_MISSING,
        status: Error::Status::PARAMETER_MISSING,
        detail: Error::Message::PARAMETER_MISSING_ERROR,
        source: { pointer: '/request/url/:id' }
      )
    end
  end
end
