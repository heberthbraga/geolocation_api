class ProviderAdapter
  def initialize(provider_instance_obj)
    @provider_instance_obj = provider_instance_obj
    @endpoint = provider_instance_obj.endpoint
  end

  def fetch_data
    Rails.logger.error("ProviderAdapter => Starting to fetch data from #{endpoint}")

    provider_response = Error::Timeout.rescue(endpoint) do
      RestClient.get(provider_instance_obj.get_address_path)
    end

    Rails.logger.debug("ProviderAdapter => Fetched data from #{endpoint} with response=#{provider_response}")

    render provider_response
  end

  private

  def render(response)
    response_keys = provider_instance_obj.response_keys.collect{|key| key.to_sym}

    values = response.values_at(*response_keys).compact

    raise Error::ProviderRequestError.new(response, endpoint) if values.empty?

    {
      country_code: values[0] || '',
      country_name: values[1] || '',
      region_code: values[2] || '',
      region_name: values[3] || '',
      city: values[4] || '',
      latitude: values[5],
      longitude: values[6],
      lookup_type: values[7] || '',
      lookup_address: values[8] || ''
    }
  end

  attr_reader :provider_instance_obj, :endpoint
end