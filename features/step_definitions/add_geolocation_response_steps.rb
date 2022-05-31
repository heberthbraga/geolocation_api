Then('then the geolocation creation response should be {string}') do |string|
  expect(last_response.ok?).to eq true
end

Then('the JSON response should be a geolocation data') do
  geolocation = JSON.parse(last_response.body, symbolize_names: true)

  expect(geolocation).not_to be_empty
  expect(geolocation[:id]).not_to be_nil
  expect(geolocation[:country_code]).not_to be_nil
  expect(geolocation[:country_name]).not_to be_nil
  expect(geolocation[:region_code]).not_to be_nil
  expect(geolocation[:region_name]).not_to be_nil
  expect(geolocation[:city]).not_to be_nil
  expect(geolocation[:latitude]).not_to be_nil
  expect(geolocation[:longitude]).not_to be_nil
  expect(geolocation[:lookup_type]).not_to be_nil
  expect(geolocation[:lookup_address]).not_to be_nil
  
  expect(Geolocation.all.size).to eq 1
end