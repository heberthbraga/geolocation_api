class Api::V1::Jwt::Decode
  prepend SimpleCommand

  def initialize(token)
    @token = token
  end

  def call
    body = JWT.decode(token, Token::Helper.secret_decode, true,
      { algorithm: 'RS256' })

    body ? (HashWithIndifferentAccess.new body[0]) : (return false)
  rescue JWT::DecodeError, JWT::VerificationError => e
    Rails.logger.error "=====> Api::V1::Jwt::Decode.error = #{e.inspect}"
    false
  end

  private

  attr_reader :token
  
end