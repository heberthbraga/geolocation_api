Before('@list-service-providers') do
  @service_provier = create(:ipstack_provider)
end

When('I send a GET request for {string}') do |service_providers_path|
  get service_providers_path
end

Then('then the response should be {string}') do |string|
  expect(last_response.ok?).to eq true
end

Then('the JSON response should be a service providers array with {string} service provider element') do |quantity|
  service_providers = JSON.parse(last_response.body, symbolize_names: true)

  expect(service_providers.size).to eq quantity.to_i
  expect(service_providers.first[:name]).to eq @service_provier.name
end
