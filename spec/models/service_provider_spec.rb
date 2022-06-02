require 'rails_helper'

describe ServiceProvider, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:clazz_name) }
  it { should validate_presence_of(:config_bundle) }

  context 'with cache' do
    it 'should flush' do
      expect(Cacher).to receive(:flush_cached_providers).and_return(double: [])
      create(:ipstack_provider)
    end
  end

  context 'when building provider instance' do
    let(:lookup_address) { Faker::Internet.ip_v6_address }

    it 'returns an object from existing instance' do
      service_provider = create(:ipstack_provider)

      provider_reference = service_provider.build_instance

      expect(provider_reference).not_to be_nil

      provider_instance = provider_reference.new(service_provider.config_bundle, lookup_address)
   
      expect(provider_instance.class.name).to eq service_provider.clazz_name
      expect(provider_instance.get_address_path).not_to be_nil
    end
  end
end