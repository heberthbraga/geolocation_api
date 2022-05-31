class ApplicationController < ActionController::API
  include Pundit::Authorization
  include ErrorHandler
  include Renderer
  
  respond_to? :json

  before_action :set_default_response_format
  before_action :authorize_request

  attr_reader :current_user

  private

  def authorize_request
    authorizer = Api::V1::Authentication::Authorize.call(request.headers)

    @current_user = authorizer.result

    if @current_user.blank?
      Rails.logger.error "AuthorizitationError => #{authorizer.errors}"
      raise Error::Unauthorized
    end
  end

  def set_default_response_format
    request.format = :json
  end
end
