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
		
		def get_payrolls(company_id, options = {})
			default_options = {
				processed: nil,
				start_date: nil,
				end_date: nil
			}
			
			options = default_options.merge(options)
			
			parameter_options = {}
			
			unless options[:processed].nil?
				parameter_options[:processed] = options[:processed]
			end
			
			unless options[:start_date].nil?
				parameter_options[:start_date] = options[:start_date]
			end
			
			unless options[:end_date].nil?
				parameter_options[:end_date] = options[:end_date]
			end
			
			path = "v1/companies/#{company_id}/payrolls"
			client.get(path, parameter_options)
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