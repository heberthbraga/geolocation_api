require 'rails_helper'

describe IpStack, type: :model do

  let(:lookup_address) { Faker::Internet.ip_v6_address }

  context 'when config bundle is blank' do
    it 'raises json parser error' do
      expect {
        ip_stack = IpStack.new('', lookup_address)
      }.to raise_error(Error::JsonParser)
    end
  end

  context 'when config bundle is empty' do
    it 'raises missing provider configuration error' do
      expect {
        ip_stack = IpStack.new('{}', lookup_address)
      }.to raise_error(Error::MissingProviderConfiguration)
    end
  end

  context 'when provider config bundle does not contain required fields' do
    it 'raises endpoint required error' do
      config_bundle = '{"host": "http://www.example.com"}'

      expect {
        ip_stack = IpStack.new(config_bundle, lookup_address)
      }.to raise_error { |error|
        expect(error).to be_a(Error::MissingProviderConfiguration)
        expect(error.detail).to eq Error::Message::PROVIDER_ENDPOINT_REQUIRED_ERROR
      }
    end

    it 'raise api key required error' do
      config_bundle = 
        '
          {
            "host": "http://www.example.com",
            "endpoint": "http://www.example.com"
          }
        '

      expect {
        ip_stack = IpStack.new(config_bundle, lookup_address)
      }.to raise_error { |error|
        expect(error).to be_a(Error::MissingProviderConfiguration)
        expect(error.detail).to eq Error::Message::PROVIDER_API_KEY_REQUIRED_ERROR
      }
    end
  end

  context 'when provider config bundle is valid' do
    let(:config_bundle) {
      '
        {
          "host": "http://www.example.com",
          "endpoint": "http://www.example.com",
          "api_key": "2176dsd62"
        }
      '
    }
    let(:ip_stack) { IpStack.new(config_bundle, lookup_address) }

    it 'returns a valid path' do
      expect(ip_stack.get_path).not_to be_nil
    end

    it 'returns a valid hash from response' do
      expect(ip_stack.to_hash(ipstack_provider_response)).not_to be_empty
    end

    it 'returns true when response has errors' do          
      expect {
        ip_stack.to_hash(ipsatck_error_response)
      }.to raise_error { |error|
        expect(error).to be_a(Error::ProviderRequestError)
        expect(error.title).to eq ipsatck_error_response[:error][:type]
      }
    end
  end
end