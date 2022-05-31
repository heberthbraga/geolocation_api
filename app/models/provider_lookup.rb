class ProviderLookup
  def initialize(provider_adapter)
    @provider_adapter = provider_adapter
  end

  def fetch_data
    provider_adapter.fetch_data
  end

  private

  attr_reader :provider_adapter
end