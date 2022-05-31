module Api
  module V1
    class ServiceProvidersController < ApplicationController
      before_action :set_service_provider, only: %i[show update destroy]

      api :GET, '/api/v1/service_providers', 'List all service providers'
      def index
        service_providers = policy_scope(ServiceProvider)

        render_response service_providers
      end

      api :POST, '/api/v1/service_providers', 'Creates a new Service Provider'
      param :service_provider, Hash, desc: 'Service provider element', required: true do
        param :name, String, desc: 'Name of the provider', required: true
        param :clazz_name, String, desc: 'Name of the provider class', required: true
        param :config_bundle, String, desc: 'Specific configuration of the provider as JSON', required: true
      end
      def create
        service_provider = authorize(ServiceProvider).new(service_provider_params)

        service_provider.save!

        render_response service_provider
      end

      api :GET, '/api/v1/service_prodivers/:id', 'Show details of a Service Provider'
      param :id, Integer, desc: 'id of the requested service provider', required: true
      def show
        render_response @service_provider
      end

      api :PUT, '/api/v1/service_prodivers/:id', 'Update an existing Service Provider'
      param :id, Integer, desc: 'id of the requested service provider', required: true
      param :service_provider, Hash, desc: 'Service provider element', required: true do
        param :name, String, desc: 'Name of the provider', required: true
        param :clazz_name, String, desc: 'Name of the provider class', required: true
        param :config_bundle, String, desc: 'Specific configuration of the provider as JSON', required: true
      end
      def update
        @service_provider.update!(service_provider_params)

        render_response @service_provider
      end

      api :DELETE, '/api/v1/service_prodivers/:id', 'Destroy an existing Service Provider'
      param :id, Integer, desc: 'id of the requested service provider', required: true
      def destroy
        @service_provider.destroy!

        render_response @service_provider
      end

      private

      def render_response(resource)
        render_json ServiceProviderSerializer, resource
      end

      def service_provider_params
        params.require(:service_provider).permit(:name, :clazz_name, :config_bundle)
      end

      def set_service_provider
        @service_provider = authorize ServiceProvider.find(params[:id])
      end
    end
  end
end