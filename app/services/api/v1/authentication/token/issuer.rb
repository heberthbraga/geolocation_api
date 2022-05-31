class Api::V1::Authentication::Token::Issuer
  prepend SimpleCommand

  def initialize(payload)
    @payload = payload
  end

  def call
    user = payload[:user]
    type = payload[:type]

    access_token = Api::V1::Authentication::Token::Create.call(user, type).result
    refresh_token = Api::V1::Authentication::Token::Refresh.call(user, type).result

    {
      access_token: access_token,
      refresh_token: refresh_token
    }
  end

  private

  attr_reader :payload
end