require 'json'

module GustoWrapper
	class Company
		attr_accessor :id, :name, :trade_name, :locations, :employees, :compensations
		
		def initialize(attributes)
			@id = attributes["id"]
			@name = attributes["name"]
			@trade_name = attributes["trade_name"]
			@locations = attributes["locations"]
			@compensations = attributes["compensations"]
		end
		
		
		def employees
			response = RestClient.get "#{Client.get_api_url}/companies/#{self.id}/employees", {:params => {:access_token => Client.access_token}}
			JSON.parse(response.body)
		end
		
		def self.find(id)
			response = RestClient.get "#{Client.get_api_url}/companies/#{id}", {:params => {:access_token => Client.access_token}}
			attributes = JSON.parse(response.body)
			
			new(attributes)
		end
		
		# def self.all
		# 	response = RestClient.get Client.get_api_url
		# 	employees = JSON.parse(response.body)
		# 	employees.map { |attributes| new(attributes) }
		# end
	end
end