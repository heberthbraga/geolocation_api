module Error
  class Status
    UNAUTHORIZED = 401
    FORBIDDEN = 403
    PARAMETER_MISSING = 400
    RECORD_NOT_FOUND = 404
    INCORRECT_CREDENTIALS = 422
    AUTHENTICATION_FAILED =  422
    SERVER_ERROR = 500
    MISSING_PROVIDER_CONFIGURATION = 400
    TIMEOUT= 408
    INVALID_REQUEST = 400
    JSON_PARSER = 859
  end
end