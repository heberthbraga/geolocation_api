class ServiceProviderSerializer < ApplicationSerializer
  set_id :id

  attributes :name, :clazz_name, :config_bundle

  # belongs_to :owner, record_type: :user, serializer: UserSerializer
end
