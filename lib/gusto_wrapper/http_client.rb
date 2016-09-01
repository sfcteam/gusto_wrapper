require 'rest-client'
require 'json'

module GustoWrapper
	class HTTPClient
		attr_accessor :base_url, :config
		
		def initialize(config, base_url)
			@config = config
			@base_url = base_url
		end
		
		def set_token(gusto_code)
			post_response = RestClient.post "#{base_url}oauth/token", client_id: config[:client_id], client_secret: config[:secret], code: gusto_code, grant_type: "authorization_code", redirect_uri: config[:redirect_url]
			post_response_parsed = JSON.parse(post_response)
			
			config[:access_token] = post_response_parsed["access_token"]
			config[:refresh_token] = post_response_parsed["refresh_token"]
		end
		
		def get_current_user
			current_user_gusto = RestClient.get "#{base_url}v1/me",  {:params => {:access_token => config[:access_token]}}
			JSON.parse(current_user_gusto.body)
		end
		
		def set_user(gusto_code)
			self.set_token(gusto_code)
			current_gusto_user = self.get_current_user
			
			current_gusto_user
		end
		
		def auth_url
			"https://api.gusto-demo.com/oauth/authorize?client_id=#{config[:client_id]}&redirect_uri=#{URI::encode(config[:redirect_url])}&response_type=code"
		end
		
		def get_params
			params = {:params => {:access_token => config[:access_token]}}
			params
		end
		
		def get(path)
			response = RestClient.get(full_url(path), get_params)
			JSON.parse(response)
		end
		
		private
		
		def full_url(path)
			"#{base_url}#{path}"
		end
	end
end