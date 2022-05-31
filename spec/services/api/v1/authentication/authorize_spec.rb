require 'rails_helper'

describe Api::V1::Authentication::Authorize, type: :service do
  subject(:context) { described_class.call(headers) }

  context 'when token is not present' do
    let(:headers) { 
      {
        'Authorization' => 'Bearer '
      } 
    }

    it 'fails' do      
      expect(context).to be_failure

      user = context.result
      errors = context.errors
      messages = errors[:invalid_token]

      expect(user).to be_nil
      expect(errors).not_to be_empty
      expect(messages.first).to eq Error::Message::INVALID_TOKEN_ERROR
    end
  end

  context 'when token is present with wrong credentials' do
    let!(:user) { create(:user) }
    let!(:token) { 'token' }
    let(:headers) { 
      {
        'Authorization' => "Bearer #{token}"
      } 
    }
    let(:decoded_token) { { sub: 10, uuid: nil, type: 'digest' } }

    it 'fails' do
      expect(Api::V1::Jwt::Decode).to receive(:call).and_return(double(result: decoded_token))
      expect(Api::V1::Authentication::Validate).to receive(:call).and_return(double(result: nil))

      expect(context).to be_failure

      user = context.result
      errors = context.errors
      messages = errors[:wrong_credentials]

      expect(user).to be_nil
      expect(errors).not_to be_empty
      expect(messages.first).to eq Error::Message::WRONG_CREDENTIALS_ERROR
    end
  end

  context 'when token is present with correct credentials' do
    let!(:user) { create(:user) }
    let!(:token) { 'token' }
    let(:headers) { 
      {
        'Authorization' => "Bearer #{token}"
      } 
    }
    let(:decoded_token) {
      { sub: user.id, uuid: nil, type: 'digest' }
    }

    it 'succeeds' do
      expect(Api::V1::Jwt::Decode).to receive(:call).and_return(double(result: decoded_token))
      expect(Api::V1::Authentication::Validate).to receive(:call).and_return(double(result: user))

      expect(context).to be_success

      current_user = context.result
      expect(current_user).not_to be_nil
      expect(current_user.email).to eq user.email
      expect(current_user.first_name).to eq user.first_name
    end
  end
end