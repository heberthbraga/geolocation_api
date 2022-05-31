require 'rails_helper'

describe Api::V1::Authentication::Token::Create, type: :service do
  subject(:context) { described_class.call(user, type) }

  context 'when creating token with success' do
    let(:user) { create(:user) }
    let(:type) { 'digest' }
    let(:token) { Faker::Crypto.sha512 }

    it 'returns a signed JWT token' do
      expect(Api::V1::Jwt::Encode).to receive(:call).and_return(double(result: token))
      
      expected_token = context.result
      expect(expected_token).not_to be_nil
      expect(expected_token).to eq token
    end
  end
end