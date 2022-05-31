Given('I am a not registered user') do
  @body = {
    account: {
      first_name: 'John',
      last_name: 'Doe',
      email: 'john@doe.com',
      password: 'test1234'
    }
  }
end

When('I send a POST request to create account for {string}') do |api_v1_accounts_create_path|
  post api_v1_accounts_create_path, @body
end

Then('then the create user account response have a {string} status') do |string|
  p last_response
  expect(last_response.ok?).to eq true
end

Then('the body should be a new user account JSON element') do
  new_user = JSON.parse(last_response.body, symbolize_names: true)

  expect(new_user).not_to be_nil
  expect(new_user[:first_name]).to eq @body[:account][:first_name]
end