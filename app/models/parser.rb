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
      response_keys = @parsed_config_bundle[:response_keys]
  
      unless endpoint.present?
        raise_provider_error(Error::Message::PROVIDER_ENDPOINT_REQUIRED_ERROR)
      end

      unless api_key.present?
        raise_provider_error(Error::Message::PROVIDER_API_KEY_REQUIRED_ERROR)
      end

      unless api_key[:name].present?
        raise_provider_error(Error::Message::PROVIDER_API_KEY_NAME_REQUIRED_ERROR)
      end

      unless api_key[:value].present?
        raise_provider_error(Error::Message::PROVIDER_API_KEY_VALUE_REQUIRED_ERROR)
      end

      unless response_keys.present?
        raise_provider_error(Error::Message::PROVIDER_RESPONSE_KEYS_REQUIRED_ERROR)
      end

      unless response_keys.all?{ |k| k.is_a?(String) }
        raise_provider_error(Error::Message::PROVIDER_RESPONSE_KEYS_INVALID_TYPE_ERROR)
      end

      @parsed_config_bundle
    end

    private

    def raise_provider_error(message)
      raise Error::MissingProviderConfiguration.new(message) 
    end
  end
end