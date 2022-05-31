require 'rails_helper'

describe Api::V1::GeolocationsController, type: :request do
  describe '#create' do
    context 'when adding a new geolocation' do
      include_context 'api_authentication'

      let(:request) {
        {
          lookup_address: '2804:14d:1289:8f37:318e:932:6fea:f519',
          provider: 'IPSTACK'
        }
      }
      let(:params) {
        {
          "id" => "20",
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

      it 'returns a new geolocation if does not exist' do
        geolocation = Geolocation.new(params)
        
        expect(Api::V1::Geolocations::Add).to receive(:call).and_return(double(result: geolocation))

        post api_v1_geolocations_path, params: request, headers: @headers

        geolocation = json_response

        expect(geolocation).not_to be_empty
        expect(geolocation[:id]).not_to be_nil
        expect(geolocation[:country_code]).not_to be_nil
        expect(geolocation[:country_name]).not_to be_nil
        expect(geolocation[:region_code]).not_to be_nil
        expect(geolocation[:region_name]).not_to be_nil
        expect(geolocation[:city]).not_to be_nil
        expect(geolocation[:latitude]).not_to be_nil
        expect(geolocation[:longitude]).not_to be_nil
        expect(geolocation[:lookup_type]).not_to be_nil
        expect(geolocation[:lookup_address]).not_to be_nil
      end

      it 'raises a timeout error when endpoint not reached' do
        service_provider = create(:ipstack_provider)
        path = "http://api.ipstack.com/#{request[:lookup_address]}?access_key=b41ec88d7ecbb32b3c2c9adb6391687e"

        allow(Api::V1::ServiceProviders::Get).to receive(:call).and_return(double(result: service_provider))
        allow(RestClient).to receive(:get).with(path).and_raise(Net::ReadTimeout)

        post api_v1_geolocations_path, params: request, headers: @headers

        expect_read_timeout_error
      end
    end
  end

  describe '#show' do
    context 'when retrieving geolocation data' do
      include_context 'api_authentication'

      it 'returns a geolocation when it exists' do
        geolocation = create(:geolocation)

        get api_v1_geolocation_path(geolocation.lookup_address), headers: @headers
  
        fetched_geolocation = json_response

        expect(fetched_geolocation).not_to be_nil
        expect(fetched_geolocation[:id].to_i).to eq geolocation.id
        expect(fetched_geolocation[:country_name]).to eq geolocation.country_name
        expect(fetched_geolocation[:country_code]).to eq geolocation.country_code
        expect(fetched_geolocation[:latitude]).to eq geolocation.latitude.to_s
      end

      it 'returns a not found error for a non existing geolocation' do
        expect do
          get api_v1_geolocation_path('test_address'), headers: @headers
          
          expect_not_found_error
        end.to raise_error(Error::NotFound)
      end
    end
  end

  describe '#destroy' do
    context 'when deleting an existing geolocation' do
      include_context 'api_authentication'

      let(:geolocation) { create(:geolocation) }

      it 'returns success' do
        lookup_address = geolocation.lookup_address

        delete api_v1_geolocation_path(lookup_address), headers: @headers

        deleted_geolocation = json_response
  
        expect(deleted_geolocation).not_to be_nil
  
        expect(deleted_geolocation[:id]).not_to be_nil
        expect(deleted_geolocation[:lookup_address]).to eq lookup_address

        existing_geolocation = Geolocation.find_by(lookup_address: lookup_address)

        expect(existing_geolocation).to be_nil
        expect(Geolocation.all.size).to eq 0
      end
    end
  end
end