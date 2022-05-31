class Api::V1::Authentication::Authenticate
  prepend SimpleCommand

  def initialize(authetication_method)
    @authetication_method = authetication_method
  end

  def call
    authenticator = authetication_method

    return unless authenticator.success?

    payload = authenticator.result
    user = payload[:user]

    Rails.logger.debug "Authenticating##{payload[:type]} user #{user.id}"

    Api::V1::Authentication::Token::Issuer.call(payload).result
  end

  private

  attr_reader :authetication_method
end