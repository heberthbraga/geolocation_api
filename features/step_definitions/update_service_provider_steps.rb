Before('@update-service-provider') do
  @service_provider = create(:ipstack_provider)
  @api_key = "2111111"
  @service_name = '1IPSTACK'

  @body = {
    service_provider: {
      name: @service_name,
      config_bundle: "
      {
        \"api_key\": \"#{@api_key}\",
        \"host\": \"api.iprandom.com\",
        \"endpoint\": \"http://api.iprandom.com/\"
      }
      "
    }
  }
end

When('I send a PUT request to update a service provider for {string}') do |api_v1_service_provider_path|
  put api_v1_service_provider_path.gsub(':id', @service_provider.id.to_s), @body.to_json
end

Then('then the update service provider response have a {string} status') do |string|
  expect(last_response.ok?).to eq true
end

Then('the JSON response should be an updated service provider') do
  updated_service_provider = JSON.parse(last_response.body, symbolize_names: true)

  expect(updated_service_provider).not_to be_nil
  expect(updated_service_provider[:name]).to eq @service_name

  config_bundle = updated_service_provider[:config_bundle]
  expect(config_bundle).not_to be_nil

  parsed_config_bundle = JSON.parse(config_bundle)
  expect(parsed_config_bundle['api_key']).to eq @api_key
end
