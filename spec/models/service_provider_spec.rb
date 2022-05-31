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

    it 'raise error when instance clazz does not exist' do
      service_provider = create(:service_provider, 
        name: 'IPRANDOM', clazz_name: 'IpRandomTest', config_bundle: '{}')
      
      expect {
        service_provider.build_instance(lookup_address)
      }.to raise_error(Error::LoadInstance)
    end

    it 'returns an object from existing instance' do
      service_provider = create(:ipstack_provider)

      instance_obj = service_provider.build_instance(lookup_address)

      expect(instance_obj).not_to be_nil
      expect(instance_obj.class.name).to eq service_provider.clazz_name.to_s
    end
  end
end