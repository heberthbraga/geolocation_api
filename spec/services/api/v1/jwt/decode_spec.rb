require 'rails_helper'

describe Api::V1::Jwt::Decode, type: :service do
  context 'when decoding a given token' do
    let(:payload) { {type: 'digest', sub: 1, uuid: nil} }
    let(:algorithm) { { algorithm: 'RS256' } }
    let(:verify) { true }

    before do
      @token = Api::V1::Jwt::Encode.call(payload).result
    end

    it 'returns the decoded payload' do      
      command = described_class.call(@token)

      decoded_payload = command.result

      expect(decoded_payload).not_to be_empty
      expect(decoded_payload[:type]).to eq payload[:type]
      expect(decoded_payload[:sub]).to eq payload[:sub]
    end

    it 'raises an JWT::DecodeError exception' do
      expect(Token::Helper).to receive(:secret_decode).and_return(File.read(Rails.root.join('keys/geolocation-pub.pem'))).twice
      expect(JWT).to receive(:decode).with(@token, Token::Helper.secret_decode, verify, algorithm).and_raise(JWT::DecodeError.new)

      command = described_class.call @token

      result = command.result
      
      expect(result).to be false
    end
  end
end