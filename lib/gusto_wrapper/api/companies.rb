module GustoWrapper
	class Companies
		
		attr_accessor :client
		
		def initialize(client)
			@client = client
		end
		
		def get(company_id)
			path = "v1/companies/#{company_id}"
			client.get(path)
		end
		
	end
end