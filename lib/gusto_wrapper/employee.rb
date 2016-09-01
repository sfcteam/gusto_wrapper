require 'json'

module GustoWrapper
	class Employee
		attr_reader :id, :version, :first_name, :middle_initial, :last_name, :email, :ssn, :date_of_birth, :terminated
		
		def initialize(attributes)
			@id = attributes["id"]
			@version = attributes["version"]
			@first_name = attributes["first_name"]
			@middle_initial = attributes["middle_initial"]
			@last_name = attributes["last_name"]
			@email = attributes["email"]
			@ssn = attributes["ssn"]
			@date_of_birth = attributes["date_of_birth"]
			@terminated = attributes["terminated"]
		end
		
		def self.find(id)
			response = RestClient.get "#{Client.get_api_url}/employees/#{id}", {:params => {:access_token => Client.access_token}}
			attributes = JSON.parse(response.body)
			
			new(attributes)
		end
	end
end
