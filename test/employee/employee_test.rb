require './test/test_helper'

class GustoWrapperEmployeeTest < Minitest::Test
	def test_exists
		assert GustoWrapper::Employee
	end
	
	def test_it_gives_back_a_single_employee
		VCR.use_cassette('one_employee') do
			employee = GustoWrapper::Employee.find(1123581321345589)
			assert_equal GustoWrapper::Employee, employee.class
			
			# Check that the fields are accessible by our model
			assert_equal 1123581321345589, employee.id
			assert_equal "db0edd04aaac4506f7edab03ac855d56", employee.version
			assert_equal "Soren", employee.first_name
			assert_equal "A", employee.middle_initial
			assert_equal "Kierkegaard", employee.last_name
			assert_equal "knight0faith@initech.biz", employee.email
			assert_equal "XXX-XX-2940", employee.ssn
			assert_equal "1813-05-05", employee.date_of_birth
			assert_equal false, employee.terminated
		end
	end
	
	def test_it_gives_back_all_the_employees
		VCR.use_cassette('all_employees') do
			result = GustoWrapper::Employee.all
			
			# Make sure that the JSON was parsed
			assert result.kind_of?(Array)
			assert result.first.kind_of?(GustoWrapper::Employee)
		end
	end
end