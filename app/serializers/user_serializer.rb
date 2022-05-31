class UserSerializer < ApplicationSerializer
  set_id :id

  attributes :first_name, :last_name, :email

  has_many :roles
end