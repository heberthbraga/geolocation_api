require 'rails_helper'

describe Api::V1::Authentication::Token::Issuer, type: :service do
  subject(:context) { described_class.call(payload) }

  context 'when issuing token access' do
    let(:payload) { 
      {
        user: create(:user),
        type: 'digest'
      } 
    }
    let(:issuer_access_response) {
      {
        access_token: 'access_token',
        refresh_token: 'refresh_token'
      }
    }

    it 'should return a access and refresh tokens' do
      expect(Api::V1::Authentication::Token::Create).to receive(:call).and_return(double(result: issuer_access_response[:access_token]))
      expect(Api::V1::Authentication::Token::Refresh).to receive(:call).and_return(double(result: issuer_access_response[:refresh_token]))

      issuer_result = context.result
      expect(issuer_result).not_to be_nil

      expect(issuer_result[:access_token]).to eq issuer_access_response[:access_token]
      expect(issuer_result[:refresh_token]).to eq issuer_access_response[:refresh_token]
    end
  end
end