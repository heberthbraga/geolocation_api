class Api::V1::Authentication::Validate
  prepend SimpleCommand
  
  def initialize(decoded_token)
    @decoded_token = decoded_token
  end

  def call
    user_id = decoded_token[:sub]

    user = User.find_by(id: user_id)

    return unless user.present?
    
    user
  end

  private

  attr_reader :decoded_token
end