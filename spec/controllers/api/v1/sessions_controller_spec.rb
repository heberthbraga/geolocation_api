require 'rails_helper'

describe Api::V1::SessionsController, type: :request do
  context 'when creating authentication by email/password' do
    before(:each) do
      @user = create(:api)
    end

    it 'succeeds' do
      post '/api/v1/sessions/digest', params: { email: @user.email, password: @user.password }

      response = json_response

      expect(response[:access_token]).not_to be_nil
      expect(response[:refresh_token]).not_to be_nil
    end

    it 'fails when email and password are not provided' do
      post '/api/v1/sessions/digest'

      response = json_response
      expect(response).not_to be_nil
      errors = response[:errors]
      expect(errors.size).to be > 0
      expect(errors.first[:title]).to eq Error::Title::INCORRECT_CREDENTIALS
    end

    it 'fails when credentials are wrong' do
      post '/api/v1/sessions/digest', params: { email: 'test@gmail.com', password: '123' }

      response = json_response
      expect(response).not_to be_nil
      errors = response[:errors]
      expect(errors.size).to be > 0
      expect(errors.first[:title]).to eq Error::Title::AUTHENTICATION_FAILED
    end
  end
end
