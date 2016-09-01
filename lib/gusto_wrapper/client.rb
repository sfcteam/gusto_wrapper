require 'json'
require 'uri'

module GustoWrapper
	class Client
		attr_reader :consumer
		
		def initialize(options = {})
			default_options = {
				dev_mode: true,
				client_id: "7e8d138177e996d00ce7470629f156e79fad97920fd140cc02d57d4f9b3a7825",
				redirect_url: "http://local.gradvisor.io/auth/gusto",
				secret: "3b4ff872ac04621074b2de107803bd0a1f8cf0470297660d35350264c6683716"
			}
			
			options = default_options.merge(options)
			
			if options[:dev_mode]
				@@api_url = API_DEMO_URL
			else
				@@api_url = API_URL
			end
			
			@@client_id = options[:client_id]
			@@redirect_url = options[:redirect_url]
			@@secret = options[:secret]
		end

		def self.get_api_url
			@@api_url
		end
		
		def set_token(gusto_code)
			post_response = RestClient.post "#{@@api_url}oauth/token", client_id: @@client_id, client_secret: @@secret, code: gusto_code, grant_type: "authorization_code", redirect_uri: @@redirect_url
			post_response_parsed = JSON.parse(post_response)
			
			@@access_token = post_response_parsed["access_token"]
			@@refresh_token = post_response_parsed["refresh_token"]
			
			@@access_token
		end
		
		def self.access_token
			@@access_token
		end
		
		def access_token
			@@access_token
		end
		
		def refresh_token
			@@refresh_token
		end
		
		def get_current_user
			current_user_gusto = RestClient.get "#{@@api_url}v1/me",  {:params => {:access_token => @@access_token}}
			JSON.parse(current_user_gusto.body)
		end
		
		def set_user(gusto_code)
			self.set_token(gusto_code)
			current_gusto_user = self.get_current_user
			
			current_gusto_user
		end
		
		def auth_url
			"https://api.gusto-demo.com/oauth/authorize?client_id=#{@@client_id}&redirect_uri=#{URI::encode(@@redirect_url)}&response_type=code"
		end
		
	end
end