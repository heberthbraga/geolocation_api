module ErrorHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from Pundit::NotAuthorizedError, with: :render_pundit_not_authorized
    rescue_from ActionController::ParameterMissing, with: :render_parameter_missing
    rescue_from Error::Unauthorized, with: :render_unauthorized_error
    rescue_from Error::AuthenticationFailed, with: :render_authentication_failed_error
    rescue_from Error::IncorrectCredentials, with: :render_incorrect_credentials_error
    rescue_from Error::MissingProviderConfiguration, with: :render_missing_provider_config_error
    rescue_from Error::ReadTimeout, with: :render_read_timeout_error
    rescue_from Error::ProviderRequestError, with: :render_provider_request_error
    rescue_from Error::LoadInstance, with: :render_load_instance_error
    rescue_from Error::JsonParser, with: :render_json_parser_error
  end

  def render_unprocessable_entity_response(exception)
    render json: ValidationErrorsSerializer.new(exception.record).serialize,
           status: :unprocessable_entity
  end

  def render_not_found_response(_exception)
    render_error Error::NotFound.new
  end

  def render_pundit_not_authorized(_exception)
    render_error Error::Forbidden.new
  end

  def render_parameter_missing(_exception)
    render_error Error::ParameterMissing.new
  end

  def render_unauthorized_error(_exception)
    render_error Error::Unauthorized.new
  end

  def render_authentication_failed_error(_exception)
    render_error Error::AuthenticationFailed.new
  end

  def render_incorrect_credentials_error(_exception)
    render_error Error::IncorrectCredentials.new
  end

  def render_missing_provider_config_error(_exception)
    render_error Error::MissingProviderConfiguration.new(_exception.message)
  end

  def render_read_timeout_error(_exception)
    render_error Error::ReadTimeout.new(_exception.source['pointer'])
  end

  def render_provider_request_error(_exception)
    render_error Error::ProviderRequestError.new(_exception.detail, _exception.source['pointer'])
  end

  def render_load_instance_error(_exception)
    render_error Error::LoadInstance.new
  end

  def render_json_parser_error(_exception)
    render_error Error::JsonParser.new(_exception.detail)
  end

  private

  def render_error(exception)
    render json: ErrorSerializer.new(exception), status: exception.status
  end
end