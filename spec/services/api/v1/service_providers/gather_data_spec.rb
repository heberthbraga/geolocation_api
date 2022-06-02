require 'rails_helper'

describe Api::V1::ServiceProviders::GatherData, type: :service do
  subject(:context) { described_class.call(lookup_address, provider) }

  context 'when fetching data' do
    let(:ipstack_provider) { create(:ipstack_provider) }
    let(:provider) { ipstack_provider.name }
    let(:lookup_address) { Faker::Internet.ip_v6_address }
    let(:provider_instance) { double(ipstack_provider.clazz_name.singularize) }
    let(:provider_instance_obj) { double('obj') }
    let(:response) {
      {
        :lookup_address => "2804:14d:1289:8f37:318e:932:6fea:f519", 
        :lookup_type => "ipv6", 
        :country_code => "BR", 
        :country_name => "Brazil", 
        :region_code => "SP", 
        :region_name => "São Paulo", 
        :city => "São Paulo", 
        :latitude =>-23.54749870300293, 
        :longitude =>-46.6361083984375
      }
    }

    it 'returns provider geolocation data' do
      expect(Api::V1::ServiceProviders::Get).to receive(:call).and_return(double(result: ipstack_provider))
      
      expect_any_instance_of(ProviderLookup).to receive(:fetch_data).and_return(response)
      
      fetched_response = context.result

      expect(fetched_response).not_to be_empty
      expect(fetched_response).to eq response
    end
  end
end