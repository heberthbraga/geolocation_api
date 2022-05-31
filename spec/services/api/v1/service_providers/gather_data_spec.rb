require 'rails_helper'

describe Api::V1::ServiceProviders::GatherData, type: :service do
  subject(:context) { described_class.call(lookup_address, provider) }

  let(:ipstack_provider) { create(:ipstack_provider) }
  let(:provider) { ipstack_provider.name }
  let(:lookup_address) { Faker::Internet.ip_v6_address }

  context 'when fetchging data' do
    let(:path) { "http://api.ipstack.com/#{lookup_address}?access_key=b41ec88d7ecbb32b3c2c9adb6391687e" }
    
    before do
      allow(Api::V1::ServiceProviders::Get).to receive(:call).and_return(double(result: ipstack_provider))
    end

    it 'returns time out error' do
      allow(RestClient).to receive(:get).with(path).and_raise(Net::ReadTimeout)

      expect {
        context.result
      }.to raise_error { |error|
        expect(error).to be_a(Error::ReadTimeout)
        expect(error.title).to eq Error::Title::READ_TIMEOUT_ERROR
      }
    end

    it 'returns provider request error' do
      allow(RestClient).to receive(:get).with(path).and_return(ipsatck_error_response)

      expect {
        context.result
      }.to raise_error { |error|
        expect(error).to be_a(Error::ProviderRequestError)
        expect(error.title).not_to be_nil
      }
    end

    it 'returns a valid data' do
      allow(RestClient).to receive(:get).with(path).and_return(ipstack_provider_response)

      data = context.result
      expect(data).not_to be_empty
      expect(data[:country_code]).not_to be_nil
      expect(data[:latitude]).not_to be_nil
    end
  end
end