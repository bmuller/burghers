require 'httparty'

module Burghers
  class Client
    URI = "http://api.opencalais.com/tag/rs/enrich"

    def initialize(license)
      @license = license
    end

    def enrich(content, content_type=nil, headers = nil)
      if content.start_with?('http://') or content.start_with?('https://')
        content = HTTParty.get(content).body
        content_type = "text/html"
      end

      if content_type.nil?
        if html?(content)
          content_type = "text/html"
        else
          content_type = "text/raw"
        end
      end

      headers = {
        'accept' => 'application/json',
        'x-calais-licenseID' => @license,
        'content-type' => content_type
      }.merge(headers || {})

      response = HTTParty.post(URI, :body => content, :headers => headers)
      if response.code != 200
        raise CalaisResponseError, "Got response code of #{response.code}: #{response}"
      end

      Response.new response.parsed_response
    end

    private

    def html?(content)
      content && content.include?("<") && content.include?(">")
    end
  end
end
