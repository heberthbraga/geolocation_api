class ServiceProvider < ApplicationRecord
  after_save :clear_cached_providers
  after_destroy :clear_cached_providers

  validates :name, presence: true, uniqueness: true
  validates :clazz_name, presence: true, uniqueness: true
  validates_presence_of :config_bundle, message: "can't be blank"

  def build_instance(lookup_address)
    provider_instance = self.clazz_name.to_s.classify.safe_constantize
     
    raise Error::LoadInstance unless provider_instance

    Rails.logger.debug("Found Provider Instance #{provider_instance}")

    provider_instance.new(self.config_bundle, lookup_address)
  end

  private

  def clear_cached_providers
    Cacher.flush_cached_providers
  end
end
