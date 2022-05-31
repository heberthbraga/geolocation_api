class Cacher
  class << self
    def fetch_cached_providers
      Rails.cache.fetch(ENV.fetch('SERVICE_PROVIDER_CACHE_KEY'), :expires_in => ENV.fetch('SERVICE_PROVIDER_CACHE_EXP_DAYS').to_i.days) do
        fetch_all_cached_providers
      end
    end

    def flush_cached_providers
      flush_cached_records(ENV.fetch('SERVICE_PROVIDER_CACHE_KEY'))
    end

    def fetch_cached_provider_by(name:)
      fetch_cached_providers.detect { |p| p.name == name }
    end

    def fetch_geolocations
      Rails.cache.fetch(ENV.fetch('GEOLOCATION_CACHE_KEY'), :expires_in => ENV.fetch('GEOLOCATION_CACHE_EXP_DAYS').to_i.days) do
        fetch_all_geolocations
      end
    end

    def flush_cached_gelocations
      flush_cached_records(ENV.fetch('GEOLOCATION_CACHE_KEY'))
    end

    def fetch_cached_geolocation_by(lookup_address:)
      fetch_geolocations.detect { |g| g.lookup_address == lookup_address }
    end

    private

    def flush_cached_records(cache_key)
      Rails.cache.delete(cache_key)
    end

    def fetch_all_cached_providers
      service_providers = ServiceProvider.all
      service_providers.map { |s| s.id != nil }.compact
      service_providers
    end

    def fetch_all_geolocations
      geolcoations = Geolocation.all
      geolcoations.map { |s| s.id != nil }.compact
      geolcoations
    end
  end
end