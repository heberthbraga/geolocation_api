class Api::V1::Authentication::Token::Create
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

    Api::V1::Jwt::Encode.call(payload).result
  end

  private

  attr_reader :user, :type
end