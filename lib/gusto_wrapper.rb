require "gusto_wrapper/http_client"
require "gusto_wrapper/api/companies"
require "gusto_wrapper/api/employees"

module GustoWrapper
	
	class Client
		
		attr_accessor :client, :companies, :employees
		
		def initialize(options = {})
			default_options = {
				dev_mode: true,
				client_id: "7e8d138177e996d00ce7470629f156e79fad97920fd140cc02d57d4f9b3a7825",
				redirect_url: "http://local.gradvisor.io/auth/gusto",
				secret: "3b4ff872ac04621074b2de107803bd0a1f8cf0470297660d35350264c6683716"
			}
			
			options = default_options.merge(options)
			
			if options[:dev_mode]
				api_url = "https://api.gusto-demo.com/"
			else
				api_url = "https://api.gusto.com/"
			end
			
			@client = HTTPClient.new options, api_url
			@companies = Companies.new @client
			@employees = Employees.new @client
		end
	end
end
