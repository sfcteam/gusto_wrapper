module GustoWrapper
	class Employees
		
		attr_accessor :client
		
		def initialize(client)
			@client = client
		end
		
		def get(employee_id)
			path = "v1/employees/#{employee_id}"
			client.get(path)
		end
		
		def get_by_company_id(company_id)
			path = "v1/companies/#{company_id}/employees"
			client.get(path)
		end
		
		def get_employee_benefits(employee_id)
			path = "v1/employees/#{employee_id}/employee_benefits"
			client.get(path)
		end
	
	end
end