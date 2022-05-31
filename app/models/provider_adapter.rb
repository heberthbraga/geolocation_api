class ProviderAdapter
  def initialize(provider_instance)
    @provider_instance = provider_instance
  end

  def fetch_data
    endpoint = provider_instance.endpoint

    Rails.logger.error("ProviderAdapter => Starting to fetch data from #{endpoint}")

    provider_response = Error::Timeout.rescue(endpoint) do
      RestClient.get(provider_instance.get_path)
    end

    Rails.logger.debug("ProviderAdapter => Fetched data from #{endpoint} with response=#{provider_response}")

    @provider_instance.to_hash(provider_response)
  end

  private

  attr_reader :provider_instance
end