require "gusto_wrapper/http_client"
require "gusto_wrapper/api/companies"
require "gusto_wrapper/api/employees"
require "gusto_wrapper/api/employee_benefits"
require "gusto_wrapper/api/company_benefits"

module GustoWrapper
	
	class Client
		
		attr_accessor :client, :companies, :employees, :employee_benefits, :company_benefits
		
		def initialize(options = {})
			default_options = {
				dev_mode: true
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
			@employee_benefits = EmployeeBenefits.new @client
			@company_benefits = CompanyBenefits.new @client
		end
	end
end
