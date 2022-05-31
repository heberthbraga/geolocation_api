require 'rails_helper'

describe Api::V1::Geolocations::Add, type: :service do
  subject(:context) { described_class.call(lookup_address, provider) }

  let(:service_provider) { create(:ipstack_provider) }

  context 'when adding adding a new geolocation that already exists for given address' do
    let(:existing_geolocation) { create(:geolocation) }
    let(:lookup_address) { existing_geolocation.lookup_address }
    let(:provider) { service_provider.name }

    it 'returns the existing geolocation' do
      fetched_geolocation = context.result

      expect(fetched_geolocation).not_to be_nil
    end
  end

  context 'when addding a new geolocation that does not exist for given address' do
    let(:lookup_address) { 'address' }
    let(:provider) { service_provider.name }
    let(:gather_data_response) {
      {
        "lookup_address"=>"2804:14d:1289:8f37:318e:932:6fea:f519", 
        "lookup_type"=>"ipv6", 
        "country_code"=>"BR", 
        "country_name"=>"Brazil", 
        "region_code"=>"SP", 
        "region_name"=>"São Paulo", 
        "city"=>"São Paulo", 
        "latitude"=>-23.54749870300293, 
        "longitude"=>-46.6361083984375
      }
    }

    it 'returns a new geolocation data' do
      expect(Api::V1::ServiceProviders::GatherData).to receive(:call).and_return(double(result: gather_data_response))
    
      geolocation = context.result

      expect(geolocation.persisted?).to eq true
      expect(geolocation).not_to be_nil
      expect(geolocation.country_code).to eq gather_data_response["country_code"]
      expect(geolocation.lookup_address).to eq gather_data_response["lookup_address"]
    end
  end
end