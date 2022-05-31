class Api::V1::Geolocations::Add
  prepend SimpleCommand

  def initialize(lookup_address, provider)
    @lookup_address = lookup_address
    @provider = provider
  end

  def call
    geolocation = Cacher.fetch_cached_geolocation_by(lookup_address: lookup_address)

    if geolocation.present?
      Rails.logger.debug("Geolocations::Add => Geolocation already exists for this address=#{lookup_address}")

      return geolocation 
    end

    Rails.logger.debug("Geolocations::Add => Starting add geolocation data for address=#{lookup_address} with provider=#{provider}")

    service_provider_data = Api::V1::ServiceProviders::GatherData.call(lookup_address, provider).result
    
    geolocation = Geolocation.new(service_provider_data)

    geolocation.save!

    Rails.logger.debug("Geolocations::Add => Geolocation saved with success")
    
    geolocation
  end

  private

  attr_reader :lookup_address, :provider
end