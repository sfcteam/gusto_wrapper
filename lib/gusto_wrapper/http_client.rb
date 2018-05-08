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
		
		def set_token_from_refresh_token(refresh_token)
			post_response = RestClient.post "#{base_url}oauth/token", client_id: config[:client_id], client_secret: config[:secret], refresh_token: refresh_token, grant_type: "refresh_token", redirect_uri: config[:redirect_url]
			post_response_parsed = JSON.parse(post_response)
			
			config[:access_token] = post_response_parsed["access_token"]
			config[:refresh_token] = post_response_parsed["refresh_token"]
		end
		
		def get_current_user
			current_user_gusto = with_error_handling { RestClient.get(full_url("v1/me"), get_params) }
			JSON.parse(current_user_gusto.body)
		end
		
		def set_user(gusto_code)
			self.set_token(gusto_code)
			current_gusto_user = self.get_current_user
			
			current_gusto_user
		end
		
		def set_user_from_refresh_token(refresh_token)
			self.set_token_from_refresh_token(refresh_token)
			current_gusto_user = self.get_current_user
			
			current_gusto_user
		end
		
		def auth_url
			"#{base_url}oauth/authorize?client_id=#{config[:client_id]}&redirect_uri=#{URI::encode(config[:redirect_url])}&response_type=code"
		end
		
		def get_params(options = false)
			params = {:access_token => config[:access_token], :params => {}}

			if options
				options.each do |option|
					params[:params][option[0]] = option[1]
				end
			end

			params
		end
		
		def post_params(payload)
			payload[:access_token] = config[:access_token]
			payload
		end

		def access_token_header
			{:access_token => config[:access_token]}
		end
		
		def get(path, options = false)
			response = with_error_handling { RestClient.get(full_url(path), get_params(options)) }
			JSON.parse(response) rescue []
		end
		
		def put(path, payload)
			response = with_error_handling { RestClient.put(full_url(path), post_params(payload), access_token_header) }
			response
		end
		
		def post(path, payload)
			response = with_error_handling { RestClient.post(full_url(path), post_params(payload), access_token_header) }
			response
		end
		
		def delete(path)
			response = with_error_handling { RestClient.delete(full_url(path), get_params(false)) }
			response
		end
		
		private
		
		def full_url(path)
			"#{base_url}#{path}"
		end
		
		def with_error_handling
			yield
		rescue => e
			return e
		end
	end
end
