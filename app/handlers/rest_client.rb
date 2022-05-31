class RestClient
  CONTENT_TYPE = 'application/json'

  class << self
    def get(url)
      http_method = ->(l_url, l_content) { HTTParty.get(l_url) }

      call_http_method(http_method, url, nil)
    end

    def call_http_method(http_method, url, body)
      response = http_method.call(url, content(body))
      JSON.parse(response.body, symbolize_names: true)
    end

    def content(body)
      content_hash = {}
      content_hash[:headers] = headers
      content_hash[:body] = body
      content_hash[:debug_output] = $stdout if debug_enabled?
      content_hash
    end

    def headers
      {
        'Access' => CONTENT_TYPE,
        'Content-Type' => CONTENT_TYPE
      }
    end

    def debug_enabled?
      Rails.configuration.universal["enable_httpparty_debug"]
    end
  end
end
