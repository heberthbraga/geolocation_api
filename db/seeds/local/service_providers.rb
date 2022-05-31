ServiceProvider.find_or_create_by(name: 'IPSTACK') do |provider|
  p 'Seeding ipstack provider'

  provider.clazz_name = 'IpStack'
  provider.config_bundle = '
    {
      "api_key": "b41ec88d7ecbb32b3c2c9adb6391687e",
      "host": "api.ipstack.com",
      "endpoint": "http://api.ipstack.com"
    }
  '
end