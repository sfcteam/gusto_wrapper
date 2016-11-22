module GustoWrapper
	class EmployeeBenefits
		attr_accessor :client
		
		def initialize(client)
			@client = client
		end
		
		def get(employee_benefit_id)
			path = "v1/employee_benefits/#{employee_benefit_id}"
			client.get(path)
		end
		
		def update(employee_benefit_id, payload)
			path = "v1/employee_benefits/#{employee_benefit_id}"
			client.put(path, payload)
		end
		
		def create(employee_id, payload)
			path = "v1/employees/#{employee_id}/employee_benefits"
			client.post(path, payload)
		end
		
		def delete(employee_benefit_id)
			path = "v1/employee_benefits/#{employee_benefit_id}"
			client.delete(path)
		end
		
	end
end