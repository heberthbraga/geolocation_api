Before('@add-geolocation-address') do
  @provider = create(:ipstack_provider)
end

When('I send a POST request to add geolocation for {string} and a given ip address') do |api_v1_gelocations_path|
  body = {
    lookup_address: '2804:14d:1289:8f37:318e:932:6fea:f519',
    provider: @provider.name
  }

  post api_v1_gelocations_path, body.to_json
end