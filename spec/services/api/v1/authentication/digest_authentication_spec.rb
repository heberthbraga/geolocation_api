require 'rails_helper'

describe Api::V1::Authentication::DigestAuthentication, type: :service do
  subject(:context) { described_class.call(email, password) }

  context 'when an user enters valid credentials' do
    let(:user) { create(:user) }
    let(:email) { user.email }
    let(:password) { user.password }

    it 'returns authentication data' do
      expect(context).to be_success
      
      auth_data = context.result

      expect(auth_data).not_to be_nil
      user = auth_data[:user]
      expect(user).not_to be_nil
      expect(user.email).to eq user.email

      type = auth_data[:type]
      expect(type).not_to be_nil
      expect(type).to eq 'digest'
    end
  end

  context 'when an user does not enter valid credentials' do
    before do
      create(:user)
    end

    let(:email) { 'john@example.com' }
    let(:password) { 'test1234' }

    it 'returns invalid credentials error' do
      expect(context).to be_failure
      expect(context.result).to be_nil

      errors = context.errors

      expect(errors).not_to be_empty
      invalid_credentials = errors[:invalid_credentials]
      expect(invalid_credentials.first).to eq Error::Message::INVALID_CREDENTIALS_ERROR
    end
  end
end

