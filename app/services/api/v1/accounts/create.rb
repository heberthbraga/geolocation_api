class Api::V1::Accounts::Create
  prepend SimpleCommand

  def initialize(payload)
    @payload = payload
  end

  def call
    Rails.logger.debug("Accounts::Create => Creating account with #{payload}")

    user = User.new(payload)

    return ValidationErrorsSerializer.new(user).serialize unless user.save

    user.add_role(:api)

    UserSerializer.new(user).to_h
  end

  private

  attr_reader :payload
end