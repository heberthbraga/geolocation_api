require 'rails_helper'

describe Api::V1::ServiceProviders::Get, type: :service do
  subject(:context) { described_class.call(provider) }
  let(:service_provider) { create(:ipstack_provider) }

  context 'when retrieving an existing service provider' do
    
    let(:provider) { service_provider.name }

    it 'returns the service provider details' do
      existing_provider = context.result

      expect(existing_provider).not_to be_nil
      expect(existing_provider.id).to eq service_provider.id
      expect(existing_provider.name).to eq service_provider.name
    end
  end

  context 'when retrieving a service provider that does not exist' do
    let(:provider) { 'IpRandomTest' }

    it 'return a provider not found error' do
      expect {
        context.result
      }.to raise_error(Error::ProviderNotFound)
    end
  end
end