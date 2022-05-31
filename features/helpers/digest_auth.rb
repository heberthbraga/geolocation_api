module DigestAuth
  def authenticate(user)
    digest_authentication = Api::V1::Authentication::DigestAuthentication.call(user.email, user.password)
    authenticator = Api::V1::Authentication::Authenticate.call(digest_authentication)
    tokens = authenticator.result
    tokens[:access_token]
  end
end