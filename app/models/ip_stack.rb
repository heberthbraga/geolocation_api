class IpStack

  attr_reader :endpoint, :host

  def initialize(config_bundle, lookup_address)
    parsed_config_bundle = Parser.parse_config_bundle(config_bundle)

    @endpoint = parsed_config_bundle[:endpoint]
    @host = parsed_config_bundle[:host]
    @api_key = parsed_config_bundle[:api_key]
    @lookup_address = lookup_address
  end

  def get_path
    "#{endpoint}/#{lookup_address}?access_key=#{api_key}"
  end

  def to_hash(response)
    handle_response_error(response) if has_errors?(response)
    
    {
      country_code: response[:country_code],
      country_name: response[:country_name],
      region_code: response[:region_code],
      region_name: response[:region_name],
      city: response[:city],
      latitude: response[:latitude],
      longitude: response[:longitude],
      lookup_type: response[:type],
      lookup_address: response[:ip]
    }
  end

  private

  def has_errors?(response)
    response[:error] && !response[:error].empty?
  end

  def handle_response_error(response)
    error = response[:error]

    raise Error::ProviderRequestError.new(error[:type], error[:info], endpoint)
  end

  attr_reader :api_key, :lookup_address
end