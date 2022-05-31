module Error
  class Timeout
    class << self
      def rescue(endpoint, &block)
        begin
          yield
        rescue Net::ReadTimeout => exception
          error_message = "****** UNRESPONSIVE TIMEOUT ****** endpoint='/#{endpoint}'"
          Rails.logger.error "====> ERROR: #{error_message}'\n"

          raise Error::ReadTimeout.new(endpoint)
        end
      end
    end
  end
end