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
			total_pages = 1
			page = 1
			per = 100
			employees = []
			while page <= total_pages
				path = "v1/companies/#{company_id}/employees?page=#{page}&per=#{per}"
				response = client.get_with_pagination(path)
				total_pages = response[:total_pages]
				employees += response[:data]
				page = page + 1
				sleep 0.5
			end
			employees
		end
		
		def get_employee_benefits(employee_id)
			path = "v1/employees/#{employee_id}/employee_benefits"
			client.get(path)
		end
	
	end
end