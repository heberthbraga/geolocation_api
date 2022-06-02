Before('@delete-geolocation') do
  @geolocation = create(:geolocation)
end

When('I send a DELETE request to delete a geolocation for {string}') do |api_v1_geolocation_path|
  delete api_v1_geolocation_path.gsub(':lookup_address', @geolocation.lookup_address)
end

Then('then the geolocation delete response should be {string}') do |string|
  expect(last_response.ok?).to eq true
end

Then('the JSON response should be a deleted geolocation data ref') do
  deleted_geolocation = JSON.parse(last_response.body, symbolize_names: true)

  expect(deleted_geolocation).not_to be_nil
  expect(deleted_geolocation[:id]).not_to be_nil
  
  expect(Geolocation.all.size).to eq 0
end