require 'rails_helper'

describe Parser, type: :model do
  context 'when parsing a valid provider config bundle' do
    let(:service_provider) { create(:ipstack_provider) }

    it 'returns a config bundle hash' do
      parsed_config_bundle = get_config_bundle_parser(service_provider.config_bundle)

      expect(parsed_config_bundle).not_to be_empty
      expect(parsed_config_bundle[:endpoint]).not_to be_nil
      expect(parsed_config_bundle[:api_key]).not_to be_nil
      expect(parsed_config_bundle[:response_keys]).not_to be_nil
    end
  end

  context 'when parsing malformed config bundle' do
    let(:config_bundle) {
      '
        {
          "api_key": { 
            name: "access_key"
            "value": "b41ec88d7ecbb32b3c2c9adb6391687e" 
          },
          "host": "api.ipstack.com",
          "response_keys": ["country_code", "country_name", "region_code", "region_name", "city", "latitude", "longitude", "type", "ip"]
        }
      '
    }

    it 'returns json parser error' do
      expect {
        get_config_bundle_parser(config_bundle)
      }.to raise_error(Error::JsonParser)
    end
  end

  context 'when config bundle endpoint is not present' do
    let(:config_bundle) {
      '
        {
          "api_key": { 
            "name": "access_key", 
            "value": "b41ec88d7ecbb32b3c2c9adb6391687e" 
          },
          "host": "api.ipstack.com",
          "response_keys": ["country_code", "country_name", "region_code", "region_name", "city", "latitude", "longitude", "type", "ip"]
        }
      '
    }

    it 'returns a endpoint required error' do
      expect {
        get_config_bundle_parser(config_bundle)
      }.to raise_error { |error| 
        expect(error).to be_a(Error::MissingProviderConfiguration)
        expect(error.detail).to eq Error::Message::PROVIDER_ENDPOINT_REQUIRED_ERROR
      }
    end
  end

  context 'when config bundle api_key is not present' do
    let(:config_bundle) {
      '
        {
          "host": "api.ipstack.com",
          "endpoint": "http://api.ipstack.com",
          "response_keys": ["country_code", "country_name", "region_code", "region_name", "city", "latitude", "longitude", "type", "ip"]
        }
      '
    }

    it 'returns an api key required error' do
      expect {
        get_config_bundle_parser(config_bundle)
      }.to raise_error { |error| 
        expect(error).to be_a(Error::MissingProviderConfiguration)
        expect(error.detail).to eq Error::Message::PROVIDER_API_KEY_REQUIRED_ERROR
      }
    end
  end

  context 'when config bundle api_key is present' do
    it 'returns api required error when api key name is not present' do
      config_bundle = '
        {
          "api_key": {"id": "20"},
          "host": "api.ipstack.com",
          "endpoint": "http://api.ipstack.com",
          "response_keys": ["country_code", "country_name", "region_code", "region_name", "city", "latitude", "longitude", "type", "ip"]
        }
      '

      expect {
        get_config_bundle_parser(config_bundle)
      }.to raise_error { |error| 
        expect(error).to be_a(Error::MissingProviderConfiguration)
        expect(error.detail).to eq Error::Message::PROVIDER_API_KEY_NAME_REQUIRED_ERROR
      }
    end

    it 'returns api required error when api key value is not present' do
      config_bundle = '
        {
          "api_key": {"name": "access_key"},
          "host": "api.ipstack.com",
          "endpoint": "http://api.ipstack.com",
          "response_keys": ["country_code", "country_name", "region_code", "region_name", "city", "latitude", "longitude", "type", "ip"]
        }
      '

      expect {
        get_config_bundle_parser(config_bundle)
      }.to raise_error { |error| 
        expect(error).to be_a(Error::MissingProviderConfiguration)
        expect(error.detail).to eq Error::Message::PROVIDER_API_KEY_VALUE_REQUIRED_ERROR
      }
    end
  end

  context 'when parsing config bundle response keys' do
    it 'returns a response keys required error when not present' do
      config_bundle = 
        '
          {
            "api_key": { 
              "name": "access_key", 
              "value": "b41ec88d7ecbb32b3c2c9adb6391687e" 
            },
            "host": "api.ipstack.com",
            "endpoint": "http://api.ipstack.com"
          }
        '
      expect {
        get_config_bundle_parser(config_bundle)
      }.to raise_error { |error| 
        expect(error).to be_a(Error::MissingProviderConfiguration)
        expect(error.detail).to eq Error::Message::PROVIDER_RESPONSE_KEYS_REQUIRED_ERROR
      }
    end

    it 'returns a response keys required error when keys are empty' do
      config_bundle = 
        '
          {
            "api_key": { 
              "name": "access_key", 
              "value": "b41ec88d7ecbb32b3c2c9adb6391687e" 
            },
            "host": "api.ipstack.com",
            "endpoint": "http://api.ipstack.com",
            "response_keys": []
          }
        '
      expect {
        get_config_bundle_parser(config_bundle)
      }.to raise_error { |error| 
        expect(error).to be_a(Error::MissingProviderConfiguration)
        expect(error.detail).to eq Error::Message::PROVIDER_RESPONSE_KEYS_REQUIRED_ERROR
      }
    end

    it 'returns invalid type error' do
      config_bundle = 
        '
          {
            "api_key": { 
              "name": "access_key", 
              "value": "b41ec88d7ecbb32b3c2c9adb6391687e" 
            },
            "host": "api.ipstack.com",
            "endpoint": "http://api.ipstack.com",
            "response_keys": ["country_code", 20]
          }
        '
      expect {
        get_config_bundle_parser(config_bundle)
      }.to raise_error { |error| 
        expect(error).to be_a(Error::MissingProviderConfiguration)
        expect(error.detail).to eq Error::Message::PROVIDER_RESPONSE_KEYS_INVALID_TYPE_ERROR
      }
    end
  end

  private

  def get_config_bundle_parser(config_bundle)
    Parser.parse_config_bundle(config_bundle)
  end
end