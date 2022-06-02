class Api::V1::ServiceProviders::GatherData
  prepend SimpleCommand

  def initialize(lookup_address, provider)
    @lookup_address = lookup_address
    @provider = provider
  end
 
  def call
    Rails.logger.info("ServiceProvider::GatherData => Fetching #{provider} data with address=#{lookup_address}")

    service_provider = Api::V1::ServiceProviders::Get.call(provider).result
    
    config_bundle = service_provider.config_bundle

    Rails.logger.debug("ServiceProvider::GatherData => Building instance with config=#{config_bundle}")
    
    provider_instance = service_provider.build_instance

    provider_instance_obj = provider_instance.new(config_bundle, lookup_address)

    Rails.logger.debug("ServiceProvider::GatherData => Preparing instance #{provider_instance_obj.inspect}")

    provider_adapter = ProviderAdapter.new(provider_instance_obj)
    
    provider_lookup = ProviderLookup.new(provider_adapter)

    provider_lookup.fetch_data
  end

  private

  attr_reader :lookup_address, :provider
end