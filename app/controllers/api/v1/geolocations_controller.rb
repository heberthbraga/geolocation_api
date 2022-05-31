module Api
  module V1
    class GeolocationsController < ApplicationController
      before_action :set_geolocation, only: %i[show destroy]

      api :POST, '/api/v1/geolocations', 'Add a new geolocation'
      param :lookup_address, String, desc: 'IPV4, IPV6 or URL', required: true
      param :provider, String, desc: 'Target provider that will gather data', required: true
      def create
        authorize :geolocation, :create?

        lookup_address = geolocation_params[:lookup_address]
        provider = geolocation_params[:provider]
        
        geolocation = Api::V1::Geolocations::Add.call(lookup_address, provider).result
        
        render_response geolocation
      end

      api :GET, '/api/v1/geolocations/:lookup_address', 'Retrieve a gelocation'
      param :lookup_address, String, desc: 'IPV4, IPV6 or URL', required: true
      def show
        render_response @geolocation
      end

      api :DELETE, '/api/v1/geolocations/:lookup_address', 'Removes a geolocation'
      param :lookup_address, String, desc: 'IPV4, IPV6 or URL', required: true
      def destroy
        @geolocation.destroy!

        render_response @geolocation
      end

      private

      def render_response(resource)
        render_json GeolocationSerializer, resource
      end

      def geolocation_params
        params.permit!
      end

      def set_geolocation
        @geolocation = Cacher.fetch_cached_geolocation_by(lookup_address: params[:lookup_address])

        raise Error::NotFound unless @geolocation.present?

        authorize @geolocation
      end
    end
  end
end