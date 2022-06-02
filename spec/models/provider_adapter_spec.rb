require 'rails_helper'

describe ProviderAdapter, type: :model do
  subject(:provider_adapter) { described_class.new(provider_instance_obj) }

  let(:lookup_address) { Faker::Internet.ip_v6_address }
  let(:path) { "http://api.ipstack.com/#{lookup_address}?access_key=b41ec88d7ecbb32b3c2c9adb6391687e" }
  let(:service_provider) { create(:ipstack_provider) }
  let(:provider_instance) { service_provider.build_instance }
  let(:provider_instance_obj) { provider_instance.new(service_provider.config_bundle, lookup_address) }

  context 'when fetchging data' do
    it 'returns time out error' do
      allow(RestClient).to receive(:get).with(path).and_raise(Net::ReadTimeout)

      expect {
        provider_adapter.fetch_data
      }.to raise_error { |error|
        expect(error).to be_a(Error::ReadTimeout)
        expect(error.title).to eq Error::Title::READ_TIMEOUT_ERROR
      }
    end

    it 'returns provider request error' do
      allow(RestClient).to receive(:get).with(path).and_return(ipsatck_error_response)

      expect {
        provider_adapter.fetch_data
      }.to raise_error { |error|
        expect(error).to be_a(Error::ProviderRequestError)
        expect(error.title).not_to be_nil
      }
    end

    it 'returns a valid data' do
      allow(RestClient).to receive(:get).with(path).and_return(ipstack_provider_response)

      fetched_data = provider_adapter.fetch_data

      expect(fetched_data).not_to be_empty
      expect(fetched_data[:country_code]).not_to be_nil
      expect(fetched_data[:latitude]).not_to be_nil
    end
  end

end