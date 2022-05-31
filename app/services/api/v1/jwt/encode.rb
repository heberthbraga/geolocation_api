class Api::V1::Jwt::Encode
  prepend SimpleCommand

  def initialize(payload, access=true)
    @payload = payload
    @access = access
  end

  def call
    token_expiry = Token::Expiry.new

    payload[:exp] = access ? token_expiry.expire_access : token_expiry.expire_refresh
    payload[:iat] = token_expiry.token_issued_at.to_i
    payload[:jti] = Token::Helper.jti

    JWT.encode(payload, Token::Helper.secret_encode, 'RS256')
  end

  private

  attr_reader :payload, :access
end
