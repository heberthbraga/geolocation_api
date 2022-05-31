Before('@get-service-provider') do
  @service_provier = create(:ipstack_provider)
end

When('I send a GET request to retrieve service provider for {string}') do |service_providers_path|
  get service_providers_path.gsub(':id', @service_provier.id.to_s)
end

Then('then the retrieve service provider response should be {string}') do |string|
  expect(last_response.ok?).to eq true
end

Then('the JSON response should be a service provider for given id') do
  fetched_service_provider = JSON.parse(last_response.body, symbolize_names: true)

  expect(fetched_service_provider).not_to be_nil
  expect(fetched_service_provider[:name]).to eq @service_provier.name
end
