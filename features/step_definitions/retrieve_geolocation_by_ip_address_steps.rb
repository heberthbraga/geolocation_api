Before('@retrieve-geolocation') do
  @geolocation = create(:geolocation)
end

When('I send a GET request to retrieve a geolocation for {string}') do |api_v1_geolocation_path|
  get api_v1_geolocation_path.gsub(':lookup_address', @geolocation.lookup_address)
end

Then('then the geolocation get response should be {string}') do |string|
  expect(last_response.ok?).to eq true
end

Then('the JSON response should be an existing geolocation data') do
  fetched_geolocation = JSON.parse(last_response.body, symbolize_names: true)

  expect(fetched_geolocation).not_to be_nil
  expect(fetched_geolocation[:id]).not_to be_nil
  expect(fetched_geolocation[:country_name]).to eq @geolocation.country_name
end