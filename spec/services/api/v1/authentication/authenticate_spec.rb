require 'rails_helper'

describe Api::V1::Authentication::Authenticate, type: :service do
  subject(:context) { described_class.call(authentication_method) }

  context 'when authenticating with valid digest credentials' do
    let(:user) { create(:user) }
    let(:digest_response) { {user: user, type: 'digest'} }
    let(:issuer_access_response) {
      {
        access_token: 'access_token',
        refresh_token: 'refresh_token'
      }
    }
    let(:authentication_method) { Api::V1::Authentication::DigestAuthentication.call(user.email, user.password) }

    it 'returns a pair of current and refresh tokens' do
      expect(Api::V1::Authentication::DigestAuthentication).to receive(:call).and_return(double(success?: true, result: digest_response ))
      expect(Api::V1::Authentication::Token::Issuer).to receive(:call).and_return(double(result: issuer_access_response))

      expect(context.result).not_to be_nil
      expect(context.result).to eq issuer_access_response 
    end
  end

  context 'when authentication fails with invalid credentials' do
    before do
      create(:user)
    end
    let(:authentication_method) { Api::V1::Authentication::DigestAuthentication.call('john@example.com', 'test') }

    it 'returns nil' do
      expect(Api::V1::Authentication::DigestAuthentication).to receive(:call).and_return(double(success?: false))
      expect(context.result).to be_nil
    end
  end
end