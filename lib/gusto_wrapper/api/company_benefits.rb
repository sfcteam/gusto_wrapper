module GustoWrapper
	class CompanyBenefits
		attr_accessor :client
		
		def initialize(client)
			@client = client
		end
		
		def get(company_benefit_id)
			path = "v1/company_benefits/#{company_benefit_id}"
			client.get(path)
		end

		def update(company_benefit_id, payload)
			path = "v1/company_benefits/#{company_benefit_id}"
			client.put(path,payload)
		end
		
		def summary(company_benefit_id, start_date=false, end_date=false, detailed=false)
			if start_date && end_date
				path = "v1/company_benefits/#{company_benefit_id}/summary"
				client.get(path, {start_date: start_date, end_date: end_date, detailed: detailed})
			elsif start_date
				path = "v1/company_benefits/#{company_benefit_id}/summary"
				client.get(path, {start_date: start_date, detailed: detailed})
			elsif end_date
				path = "v1/company_benefits/#{company_benefit_id}/summary"
				client.get(path, {end_date: end_date, detailed: detailed})
			else
				path = "v1/company_benefits/#{company_benefit_id}/summary"
				client.get(path, {detailed: detailed})
			end
		end
	
	end
end