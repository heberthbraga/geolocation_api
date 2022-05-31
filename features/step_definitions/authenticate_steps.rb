Before('@authenticate') do
  @user = create(:api)
end

Given('I am a registered api user') do
  expect(@user.api?).to eq true
end

When('I send a POST request for {string} as JSON') do |sessions_digest_path|
  header 'Accept', 'application/json'
  header 'Content-Type', 'application/json'

  body = {
    email: @user.email,
    password: @user.password
  }

  post sessions_digest_path, body.to_json
end

Then('the body should be the user access and refresh tokens') do
  tokens = JSON.parse(last_response.body, symbolize_names: true)

  expect(tokens).not_to be_empty
  expect(tokens[:access_token]).not_to be_nil
  expect(tokens[:refresh_token]).not_to be_nil
end