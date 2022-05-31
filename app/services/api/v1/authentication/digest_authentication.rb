class Api::V1::Authentication::DigestAuthentication
  prepend SimpleCommand

  def initialize(email, password)
    @email = email
    @password = password
  end

  def call
    Rails.logger.debug("DigestAuthentication: Authenticating user=#{email}")

    user = User.find_by(email: email.downcase)

    return { user: user, type: 'digest' } if user&.authenticate(password)

    errors.add(:invalid_credentials, Error::Message::INVALID_CREDENTIALS_ERROR)
    nil
  end

  private

  attr_reader :email, :password
end