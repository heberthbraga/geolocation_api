class Api::V1::Authentication::Token::Refresh
  prepend SimpleCommand

  def initialize(user, type)
    @user = user
    @type = type
  end

  def call
    payload = {
      uuid: nil,
      sub: user.id,
      type: type
    }

    # add to a whitelist

    Api::V1::Jwt::Encode.call(payload, false).result
  end

  private

  attr_reader :user, :type
end