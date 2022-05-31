class Api::V1::ServiceProviders::Get
  prepend SimpleCommand

  def initialize(provider)
    @provider = provider
  end

  def call
    service_provider = Cacher.fetch_cached_provider_by(name: provider)
    
    raise Error::ProviderNotFound unless service_provider.present?

    service_provider
  end

  private

  attr_reader :provider
end