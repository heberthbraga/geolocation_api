shared_context 'api_authentication' do
  before do
    @user, @headers = authenticate(user_type: :api)
  end
end

shared_context 'admin_authentication' do
  before do
    @user, @headers = authenticate(user_type: :admin)
  end
end

def authenticate(user_type:)
  user = create(user_type)

  post '/api/v1/sessions/digest', params: { email: user.email, password: user.password }

  response = json_response

  access_token = response[:access_token]

  expect(access_token).not_to be_nil
  expect(response[:refresh_token]).not_to be_nil

  headers = { 'Authorization' => "Bearer #{access_token}" }

  [user, headers]
end