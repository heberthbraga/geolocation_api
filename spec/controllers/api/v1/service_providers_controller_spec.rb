require 'rails_helper'

describe Api::V1::ServiceProvidersController, type: :request do
  describe '#index' do
    context 'when admin is fetching service providers' do
      include_context 'admin_authentication'

      before do
        create(:ipstack_provider)
      end

      it 'returns a list of service providers' do
        get api_v1_service_providers_path, headers: @headers

        service_providers = json_response

        expect(service_providers).not_to be_empty
        expect(service_providers.first[:name]).to eq 'IPSTACK'
      end
    end

    context 'when not admin user is fetching service providers' do
      include_context 'api_authentication'

      it 'should return forbidden error' do
        get api_v1_service_providers_path, headers: @headers

        expect_forbidden_error
      end
    end
  end

  describe '#create' do
    context 'when admin create a service provider' do
      include_context 'admin_authentication'
      
      it 'returns a new service provider element with valid params' do
        post api_v1_service_providers_path, params: {
          service_provider: {
            name: 'test',
            clazz_name: 'Test',
            config_bundle: '{"endpoint": "foo"}'
          }
        }, headers: @headers

        service_provider = json_response
        expect(service_provider).not_to be_nil
        expect(service_provider[:id]).not_to be_nil
        expect(service_provider[:name]).not_to be_nil
        expect(service_provider[:clazz_name]).not_to be_nil
        expect(service_provider[:config_bundle]).not_to be_nil
      end

      it 'returns validation errors for invalid params' do
        post api_v1_service_providers_path, params: {
          service_provider: {
            name: nil,
            clazz_name: nil,
            config_bundle: nil
          }
        }, headers: @headers

        expect_validation_error(3)
      end
    end

    context 'when not admin user tries to create a service provider' do
      include_context 'api_authentication'

      it 'should return forbidden error' do
        post api_v1_service_providers_path, params: {
          service_provider: {
            name: 'test',
            clazz_name: 'Test',
            config_bundle: '{"endpoint": "foo"}'
          }
        }, headers: @headers

        expect_forbidden_error
      end
    end
  end

  describe '#show' do
    context 'when retrieving service provider details' do
      include_context 'admin_authentication'

      it 'returns a service provider when it exists' do
        service_provider = create(:ipstack_provider)
        get api_v1_service_provider_path(service_provider.id), headers: @headers
  
        fetched_service_provider = json_response

        expect(fetched_service_provider).not_to be_nil
        expect(fetched_service_provider[:id].to_i).to eq service_provider.id
        expect(fetched_service_provider[:name]).to eq service_provider.name
        expect(fetched_service_provider[:clazz_name]).to eq service_provider.clazz_name
        expect(fetched_service_provider[:config_bundle]).to eq service_provider.config_bundle
      end

      it 'returns a not found error for a non existing service provider' do
        get api_v1_service_provider_path(1000), headers: @headers

        expect_not_found_error
      end
    end
  end

  describe '#update' do
    context 'when admin updates a service provider' do
      include_context 'admin_authentication'
      
      before(:each) do
        @service_provider = create(:ipstack_provider)
      end
      
      it 'returns the existing and updated service provider with valid params' do
        put api_v1_service_provider_path(@service_provider.id), params: {
          service_provider: {
            name: '1IPSTACK'
          }
        }, headers: @headers

        updated_service_provider = json_response
        expect(updated_service_provider).not_to be_nil
        expect(updated_service_provider[:name]).to eq '1IPSTACK'
        expect(updated_service_provider[:name]).not_to eq @service_provider.name
      end

      it 'returns validation errors for invalid params' do
        put api_v1_service_provider_path(@service_provider.id), params: {
          service_provider: {
            name: nil,
            clazz_name: nil,
            config_bundle: nil
          }
        }, headers: @headers

        expect_validation_error(3)
      end
    end
  end

  describe '#destroy' do
    context 'when deleting an existing service provider' do
      include_context 'admin_authentication'

      let(:service_provider) { create(:ipstack_provider) }

      it 'returns success' do
        id = service_provider.id

        delete api_v1_service_provider_path(id), headers: @headers

        deleted_service_provider = json_response
  
        expect(deleted_service_provider).not_to be_nil
  
        expect(deleted_service_provider[:id]).not_to be_nil
        expect(deleted_service_provider[:id]).to eq id.to_s

        existing_service_provider = ServiceProvider.find_by(id: id)

        expect(existing_service_provider).to be_nil
        expect(ServiceProvider.all.size).to eq 0
      end
    end
  end
end