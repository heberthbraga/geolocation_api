FactoryBot.define do
  factory :service_provider, class: ServiceProvider do
    factory :ipstack_provider do
      name { 'IPSTACK' }
      clazz_name { 'IpStack' }
      config_bundle {
        '
          {
            "api_key": { 
              "name": "access_key", 
              "value": "b41ec88d7ecbb32b3c2c9adb6391687e" 
            },
            "host": "api.ipstack.com",
            "endpoint": "http://api.ipstack.com",
            "response_keys": ["country_code", "country_name", "region_code", "region_name", "city", "latitude", "longitude", "type", "ip"]
          }
        '
      }
    end
  end
end