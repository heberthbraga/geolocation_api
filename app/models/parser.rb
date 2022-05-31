class Parser
  class << self
    def parse_config_bundle(config_bundle)
      Rails.logger.debug("Parsing config bundle #{config_bundle}")
      
      begin
        @parsed_config_bundle = JSON.parse(config_bundle, symbolize_names: true)
      rescue JSON::ParserError => e
        raise Error::JsonParser.new(e.message)
      end
      
      raise Error::MissingProviderConfiguration if @parsed_config_bundle.empty?
  
      endpoint = @parsed_config_bundle[:endpoint]
      api_key = @parsed_config_bundle[:api_key]
  
      unless endpoint.present?
        raise_provider_error(Error::Message::PROVIDER_ENDPOINT_REQUIRED_ERROR)
      end

      unless api_key.present?
        raise_provider_error(Error::Message::PROVIDER_API_KEY_REQUIRED_ERROR)
      end

      @parsed_config_bundle
    end

    private

    def raise_provider_error(message)
      raise Error::MissingProviderConfiguration.new(message) 
    end
  end
end