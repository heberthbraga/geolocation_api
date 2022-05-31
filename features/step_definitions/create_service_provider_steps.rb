Before('@create-service-provider') do
  @body = {
    service_provider: {
      name: 'IPRANDOM',
      clazz_name: 'IpRandom',
      config_bundle: '{"endpoint": "test"}'
    }
  }
end

When('I send a POST request for {string}') do |service_providers_path|
  post service_providers_path, @body.to_json
end

Then('then the create service provider response have a {string} status') do |string|
  expect(last_response.ok?).to eq true
end

Then('the body should be a new service provider JSON element') do
  service_provider = JSON.parse(last_response.body, symbolize_names: true)
  
  expect(service_provider).not_to be_nil
  expect(service_provider[:name]).to eq @body[:service_provider][:name]
end