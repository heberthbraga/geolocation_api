module Api
  module V1
    class AccountsController < ApplicationController
      skip_before_action :authorize_request, only: :create

      api :POST, '/api/v1/accounts/create', 'Creates a new user account'
      param :account, Hash, desc: 'New account element', required: true do
        param :first_name, String, desc: 'User first name', required: true
        param :last_name, String, desc: 'User last_response name', required: true
        param :email, String, desc: 'User email', required: true
        param :password, String, desc: 'User password', required: true
      end
      def create
        response = Api::V1::Accounts::Create.call(account_params).result

        render json: response
      end

      private

      def account_params
        params.require(:account).permit(:first_name, :last_name, :email, :password)
      end
    end
  end
end