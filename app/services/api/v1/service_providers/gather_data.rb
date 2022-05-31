class Api::V1::ServiceProviders::GatherData
  prepend SimpleCommand

  def initialize(lookup_address, provider)
    @lookup_address = lookup_address
    @provider = provider
  end
 
  def call
    Rails.logger.info("ServiceProvider::GatherData => Fetching #{provider} data with address=#{lookup_address}")

    service_provider = Api::V1::ServiceProviders::Get.call(provider).result
    
    provider_instance = service_provider.build_instance(lookup_address)

    Rails.logger.debug("ServiceProvider::GatherData => Preparing instance #{provider_instance.inspect}")

    provider_adapter = ProviderAdapter.new(provider_instance)
    
    provider_lookup = ProviderLookup.new(provider_adapter)

    provider_lookup.fetch_data
  end

  private

  attr_reader :lookup_address, :provider
end