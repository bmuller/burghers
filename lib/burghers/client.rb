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

      if content_type.nil? and content.include?("<") and content.include(">")
        content_type = "text/html"
      elsif content_type.nil?
        content_type = "text/raw"
      end

      headers = {
        'accept' => 'application/json',
        'x-calais-licenseID' => @license,
        'content-type' => content_type
      }.merge(headers || {})

      response = HTTParty.post(URI, :body => content, :headers => headers)
      if response.code != 200
        raise "Got response code of #{response.code}: #{response}"
      end
      
      Response.new response.parsed_response
    end
  end
end
