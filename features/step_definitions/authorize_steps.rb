Given('I am a valid {string} user') do |user_type|
  user = create(user_type.to_sym)
  @token = authenticate(user)
  expect(@token).not_to be_nil
end

Given('I send and accept JSON') do
  header 'Accept', 'application/json'
  header 'Content-Type', 'application/json'
end

Given('I send an authorization token') do
  header 'Authorization', "Bearer #{@token}"
end