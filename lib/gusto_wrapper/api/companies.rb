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
		
		def get_company_benefits(company_id)
			path = "v1/companies/#{company_id}/company_benefits"
			client.get(path)
		end
		
		def get_payrolls(company_id)
			path = "v1/companies/#{company_id}/payrolls"
			client.get(path)
		end
		
		def get_unprocessed_payrolls(company_id)
			path = "v1/companies/#{company_id}/payrolls"
			client.get(path, {processed: false})
		end
		
		def get_processed_payrolls(company_id)
			path = "v1/companies/#{company_id}/payrolls"
			client.get(path, {processed: true})
		end
		
		def get_available_benefits
			path = "v1/benefits"
			client.get(path)
		end
		
		def create_company_benefit(company_id, benefit_id, active, description)
			path = "v1/companies/#{company_id}/company_benefits"
			params = {
				benefit_id: benefit_id,
				active: active,
				description: description
			}
			
			client.post(path, params)
		end
		
	end
end