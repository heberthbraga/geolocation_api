class User < ApplicationRecord
  rolify
  has_secure_password

  validates :email, presence: true, uniqueness: { case_sensitive: true }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :first_name, :last_name, presence: true

  def admin?
    has_role?(:admin)
  end

  def api?
    has_role?(:api)
  end
end
