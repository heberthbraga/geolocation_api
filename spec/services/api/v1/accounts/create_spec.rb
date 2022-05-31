require 'rails_helper'

describe Api::V1::Accounts::Create, type: :service do
  subject(:context) { described_class.call(payload) }

  context 'when validating a new account' do
    let(:payload) {
      {
        first_name: nil,
        last_name: nil,
        email: nil,
        password: nil
      }
    }

    it 'returns validation errors' do
      response = context.result

      expect(response).not_to be_empty
      expect(response[:title]).to eq Error::Title::VALIDATION_FAILED
      
      errors = response[:errors]

      expect(errors.size).to eq 5

      errors.each do |error|
        expect(error[:resource]).to eq 'User'
        expect(error[:field]).not_to be_nil
        expect(error[:code]).not_to be_nil
      end
    end
  end

  context 'when creating a new account with success' do
    let(:payload) {
      {
        first_name: 'John',
        last_name: 'Doe',
        email: 'john@example.com',
        password: 'test1234'
      }
    }

    it 'returns a new user payload' do
      user_payload = context.result

      expect(user_payload).not_to be_empty
      expect(user_payload[:first_name]).to eq payload[:first_name]

      roles = user_payload[:roles]
      
      expect(roles.size).to eq 1
      expect(roles[0][:name]).to eq 'api'
    end
  end
end