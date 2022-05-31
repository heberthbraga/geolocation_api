require 'rails_helper'

describe Api::V1::AccountsController, type: :request do
  describe '#create' do
    context 'when creating an account with success' do
      it 'returns a new user' do
        user = create(:api)
        expect(Api::V1::Accounts::Create).to receive(:call).and_return(double(result: UserSerializer.new(user).to_h))

        post api_v1_accounts_create_path, params: {
          account: {
            first_name: 'Foo',
            last_name: 'Yo',
            email: 'foo@example.com',
            password: 'test1234'
          }
        }
  
        new_user = json_response
  
        expect(new_user).not_to be_nil
        expect(new_user[:first_name]).to eq user.first_name
        expect(new_user[:last_name]).to eq user.last_name
        expect(new_user[:email]).to eq user.email
      end
    end
  end
end