class Api::V1::Authentication::Authorize
  prepend SimpleCommand

  def initialize(headers)
    @token = headers['Authorization']&.split('Bearer ')&.last
  end

  def call
    decoded_token = decode

    return unless decoded_token

    @user = Api::V1::Authentication::Validate.call(decoded_token).result

    @user || errors.add(:wrong_credentials, Error::Message::WRONG_CREDENTIALS_ERROR)
  end

  private

  attr_reader :token

  def decode
    return Api::V1::Jwt::Decode.call(token).result if token.present?

    errors.add(:invalid_token, Error::Message::INVALID_TOKEN_ERROR)

    nil
  end
end