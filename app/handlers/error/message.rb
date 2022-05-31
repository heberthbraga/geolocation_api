module Error
  class Message
    INVALID_CREDENTIALS_ERROR = 'Invalid Credentials!'
    WRONG_CREDENTIALS_ERROR = 'Wrong Credentials!'
    INVALID_TOKEN_ERROR = 'Invalid Token!'
    DEFAULT_DETAIL_ERROR = 'We encountered unexpected error, but our developers had been already notified about it.'
    DEFAULT_TITLE_ERROR = 'Something went wrong!'
    UNAUTHOROZED_ERROR = 'You are not authorized.'
    AUTHENTICATION_FAILED_ERROR = 'Failed to authenticate.'
    INCORRECT_CREDENTIALS_ERROR = 'Please, specify an email and password.'
    UNAUTHOROZED_PUNDIT_ERROR = 'You are not authorized to perform this action.'
    RECORD_NOT_FOUND_ERROR = 'Record not Found.'
    PARAMETER_MISSING_ERROR = 'param is missing or the value is empty.'
    PROVIDER_NOT_FOUND_ERROR = 'Provider not Found.'
    MISSING_PROVIDER_CONFIGURATION_ERROR = 'Missing Provider configuration bundle info.'
    READ_TIMEOUT_ERROR = 'Looks like the server is taking to long to respond, this can be caused by either poor connectivity or an error with our servers. Please try again in a while.'
    PROVIDER_INSTANCE_NOT_FOUND_ERROR = "Couldn't load provider instance."
    PROVIDER_ENDPOINT_REQUIRED_ERROR = 'Provider endopoint is required.'
    PROVIDER_API_KEY_REQUIRED_ERROR = 'Provider api key is required.'
  end
end