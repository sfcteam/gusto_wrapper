require 'faraday'
require 'json'

module GustoWrapper
	class Client
		GUSTO_API_URL = "https://api.gusto.com"
		
		attr_reader :access_token
		
		def initialize(options = {})
			@access_token = options.with_indifferent_access[:access_token]
		end
		
		def connection
			Faraday.new(connection_options) do |req|
				req.adapter :net_http
			end
		end
	end
end