Before('@delete-service-provider') do
  service_provider = create(:ipstack_provider)
  @id = service_provider.id
end

When('I send a DELETE request to remove a service provider for {string}') do |api_v1_service_provider_path|
  delete api_v1_service_provider_path.gsub(':id', @id.to_s)
end

Then('then the delete service provider response should be {string}') do |string|
  expect(last_response.ok?).to eq true
end

Then('the service provider is not stored in the system') do
  existing_service_provider = ServiceProvider.find_by(id: @id)
  expect(existing_service_provider).to be_nil

  expect(ServiceProvider.all.size).to eq 0  
end