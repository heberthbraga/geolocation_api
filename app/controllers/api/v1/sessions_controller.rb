module Api
  module V1
    class SessionsController < ApplicationController
      skip_before_action :authorize_request, only: :digest

      api :POST, '/api/v1/sessions/digest', 'Sign in a registered user by email/password'
      param :email, String, desc: 'User email', required: true
      param :password, String, desc: 'User password', required: true
      def digest
        email = params[:email]
        password = params[:password]

        if email && password
          digest_auth = Api::V1::Authentication::DigestAuthentication.call(email, password)
          tokens = Api::V1::Authentication::Authenticate.call(digest_auth).result
          
          if tokens.present?
            render json: tokens
          else
            raise Error::AuthenticationFailed
          end
        else
          raise Error::IncorrectCredentials
        end
      end
    end
  end
end