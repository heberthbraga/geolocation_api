class Token::Helper
  class << self
    def jti
      SecureRandom.hex
    end

    def secret_encode
      return if Rails.env.production?

      OpenSSL::PKey::RSA.new(File.read(Rails.root.join('keys/geolocation.pem')))
    end

    def secret_decode
      return if Rails.env.production?

      OpenSSL::PKey::RSA.new(File.read(Rails.root.join('keys/geolocation-pub.pem')))
    end
  end
end